#!/bin/bash
# =============================================================
# RSI-002 Snapshot — Backup all subject workspaces
# Author: Mia 🌸 | Date: 2026-02-20
#
# Usage: ./snapshot.sh [label]
# Example: ./snapshot.sh pre-session-1
# =============================================================

LABEL="${1:-snapshot}"
TIMESTAMP=$(date +%Y%m%dT%H%M%S)
BACKUP_DIR="/Users/miguelitodeguzman/ailab/lab-protocol/experiments/rsi-002/data/backups/${LABEL}-${TIMESTAMP}"

mkdir -p "$BACKUP_DIR"

echo "=== RSI-002 Snapshot: $LABEL ==="
echo "Time: $(date +%Y-%m-%dT%H:%M:%S%z)"
echo "Backup dir: $BACKUP_DIR"
echo ""

SUBJECTS=(
  "lab-rsi002-john-a-1"
  "lab-rsi002-john-b-1"
  "lab-rsi002-john-a-2"
  "lab-rsi002-john-b-2"
  "lab-rsi002-john-a-3"
  "lab-rsi002-john-b-3"
  "lab-rsi002-john-a-4"
  "lab-rsi002-john-b-4"
)

for SUBJECT in "${SUBJECTS[@]}"; do
  SUBJECT_SHORT="${SUBJECT#lab-rsi002-}"
  DEST="$BACKUP_DIR/$SUBJECT_SHORT"
  mkdir -p "$DEST"
  
  echo "📸 Snapshotting $SUBJECT_SHORT..."
  docker cp "$SUBJECT:/workspace/." "$DEST/" 2>/dev/null
  
  if [ $? -eq 0 ]; then
    FILE_COUNT=$(find "$DEST" -type f | wc -l | tr -d ' ')
    SIZE=$(du -sh "$DEST" | cut -f1)
    echo "   ✅ $FILE_COUNT files, $SIZE"
  else
    echo "   ⚠️ Failed (container may be stopped)"
  fi
done

echo ""
echo "=== Snapshot complete: $BACKUP_DIR ==="
