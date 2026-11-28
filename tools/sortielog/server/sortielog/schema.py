"""Row schema shared with the SortieLog Windower addon (keep COLUMNS in sync)."""

COLUMNS = [
    "v", "t", "session", "seq", "zone", "kind", "actor", "actor_id", "is_me", "target", "target_id",
    "target_hpp", "ws", "damage", "crit", "hand", "msg", "tp", "job", "buffs", "mob_status",
    "flags", "wall_same", "wall_distinct", "detail", "attack", "accuracy", "acc_sub", "weapon",
    "main_weapon", "main_dmg", "sub_weapon", "sub_dmg",
]

INT_FIELDS = {
    "v", "seq", "actor_id", "is_me", "target_id", "target_hpp", "damage", "crit", "hand", "msg", "tp",
    "wall_same", "wall_distinct", "attack", "accuracy", "acc_sub", "main_dmg", "sub_dmg",
}
FLOAT_FIELDS = {"t"}


def _to_int(value):
    if value is None or value == "":
        return None
    try:
        return int(float(value))
    except (TypeError, ValueError):
        return None


def _to_float(value):
    if value is None or value == "":
        return None
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def normalize(obj):
    """Coerce an incoming dict (JSON or CSV row) to typed columns; unknown keys are dropped."""
    row = {}
    for column in COLUMNS:
        value = obj.get(column)
        if column in INT_FIELDS:
            row[column] = _to_int(value)
        elif column in FLOAT_FIELDS:
            row[column] = _to_float(value)
        else:
            row[column] = None if value is None or value == "" else str(value)
    return row


def split_list(value):
    """Split a ';'-joined list column (buffs, mob_status, flags)."""
    if not value:
        return []
    return [part for part in value.split(";") if part]
