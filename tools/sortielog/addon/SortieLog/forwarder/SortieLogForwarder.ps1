<#
.SYNOPSIS
    Ships SortieLog CSV rows to a SortieLog server over HTTPS while you play.

.DESCRIPTION
    Watches the SortieLog addon's data\logs folder and POSTs new complete lines to
    <url>/ingest/csv with your player key. Progress is saved per file, so it resumes
    after restarts or server outages. The server ignores rows it already has.

    Settings come from forwarder.json next to this script (created on first run),
    or from -Url / -Key.

.EXAMPLE
    .\SortieLogForwarder.ps1
    .\SortieLogForwarder.ps1 -Url https://sortie.example.com -Key abc123
#>
param(
    [string]$Url,
    [string]$Key,
    [string]$LogDir = (Join-Path $PSScriptRoot '..\data\logs'),
    [int]$IntervalSeconds = 3,
    [int]$BatchLines = 2000,
    [switch]$Once
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$configPath = Join-Path $PSScriptRoot 'forwarder.json'
$statePath = Join-Path $PSScriptRoot 'forwarder-state.json'

if (Test-Path $configPath) {
    $config = Get-Content $configPath -Raw | ConvertFrom-Json
    if (-not $Url) { $Url = $config.url }
    if (-not $Key) { $Key = $config.key }
}
if (-not $Url -or -not $Key -or $Key -eq 'paste-your-key-here') {
    if (-not (Test-Path $configPath)) {
        @{ url = 'https://sortie.example.com'; key = 'paste-your-key-here' } |
            ConvertTo-Json | Set-Content -Path $configPath -Encoding UTF8
    }
    Write-Host "Put your server url and key in $configPath (or pass -Url and -Key), then run again."
    exit 1
}
$endpoint = $Url.TrimEnd('/') + '/ingest/csv'

$state = @{}
if (Test-Path $statePath) {
    $loaded = Get-Content $statePath -Raw | ConvertFrom-Json
    foreach ($property in $loaded.PSObject.Properties) { $state[$property.Name] = [long]$property.Value }
}
$headers = @{}

function Save-State {
    $state | ConvertTo-Json | Set-Content -Path $statePath -Encoding UTF8
}

function Open-Shared([string]$path) {
    # The addon keeps the CSV open for appending, so share read/write access.
    return [IO.File]::Open($path, [IO.FileMode]::Open, [IO.FileAccess]::Read, [IO.FileShare]::ReadWrite)
}

function Get-Header([string]$path) {
    $stream = Open-Shared $path
    $reader = New-Object IO.StreamReader($stream, [Text.Encoding]::UTF8)
    try { return $reader.ReadLine() } finally { $reader.Dispose() }
}

function Read-NewBytes([string]$path, [long]$offset) {
    $stream = Open-Shared $path
    try {
        $available = $stream.Length - $offset
        if ($available -le 0) { return ,([byte[]]@()) }
        $count = [int][Math]::Min($available, 8MB)
        $buffer = New-Object byte[] $count
        [void]$stream.Seek($offset, [IO.SeekOrigin]::Begin)
        $read = 0
        while ($read -lt $count) {
            $n = $stream.Read($buffer, $read, $count - $read)
            if ($n -le 0) { break }
            $read += $n
        }
        if ($read -lt $count) {
            $trimmed = New-Object byte[] $read
            [Array]::Copy($buffer, $trimmed, $read)
            $buffer = $trimmed
        }
        return ,$buffer
    } finally { $stream.Dispose() }
}

function Send-File($file) {
    # Returns 'idle', 'sent', 'more' (a full batch was sent) or 'failed'.
    $name = $file.Name
    $offset = if ($state.ContainsKey($name)) { $state[$name] } else { [long]0 }
    if ($file.Length -lt $offset) { $offset = [long]0 }  # file was replaced
    $bytes = Read-NewBytes $file.FullName $offset
    if ($bytes.Length -eq 0) { return 'idle' }

    # Only send complete lines, at most $BatchLines of them.
    $end = -1; $lines = 0; $pos = 0
    while ($lines -lt $BatchLines) {
        $index = [Array]::IndexOf($bytes, [byte]10, $pos)
        if ($index -lt 0) { break }
        $end = $index; $lines++; $pos = $index + 1
    }
    if ($end -lt 0) { return 'idle' }
    $length = $end + 1
    $text = [Text.Encoding]::UTF8.GetString($bytes, 0, $length)
    if ($offset -gt 0) {
        if (-not $headers.ContainsKey($name)) { $headers[$name] = Get-Header $file.FullName }
        $text = $headers[$name] + "`n" + $text
    }

    try {
        $response = Invoke-WebRequest -Uri $endpoint -Method Post -UseBasicParsing -TimeoutSec 20 `
            -Body ([Text.Encoding]::UTF8.GetBytes($text)) -ContentType 'text/csv; charset=utf-8' `
            -Headers @{ 'X-Token' = $Key } -UserAgent 'SortieLogForwarder/0.1'
    } catch {
        Write-Warning ("{0} upload failed for {1}: {2}" -f (Get-Date -Format T), $name, $_.Exception.Message)
        return 'failed'
    }
    $result = $response.Content | ConvertFrom-Json
    $state[$name] = $offset + $length
    Save-State
    Write-Host ("{0} {1}: sent {2} rows, {3} new" -f (Get-Date -Format T), $name, $result.received, $result.accepted)
    if ($lines -ge $BatchLines) { return 'more' }
    return 'sent'
}

Write-Host "SortieLog forwarder: $LogDir -> $endpoint (Ctrl+C to stop)"
$delay = $IntervalSeconds
while ($true) {
    if (Test-Path $LogDir) {
        do {
            $more = $false; $failed = $false
            foreach ($file in Get-ChildItem -Path $LogDir -Filter '*.csv' | Sort-Object Name) {
                $status = Send-File $file
                if ($status -eq 'more') { $more = $true }
                if ($status -eq 'failed') { $failed = $true; break }
            }
        } while ($more -and -not $failed)
        # Back off while the server is unreachable, up to a minute.
        $delay = if ($failed) { [Math]::Min($delay * 2, 60) } else { $IntervalSeconds }
    } else {
        Write-Warning "Log folder not found yet: $LogDir"
    }
    if ($Once) { break }
    Start-Sleep -Seconds $delay
}
