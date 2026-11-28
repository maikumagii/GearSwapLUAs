FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    SORTIELOG_DB=/data/sortielog.db \
    SORTIELOG_UDP_PORT=5140

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY sortielog ./sortielog

RUN useradd --system --uid 1000 sortielog && mkdir -p /data && chown sortielog /data
USER sortielog
VOLUME ["/data"]
EXPOSE 8080 5140/udp

CMD ["uvicorn", "sortielog.app:app", "--host", "0.0.0.0", "--port", "8080"]
