#!/usr/bin/env bash
set -euo pipefail

CODEX_SKILLS="${CODEX_HOME:-$HOME/.codex}/skills"
DEST="$CODEX_SKILLS/rnaseq-de"

mkdir -p "$DEST"
cp -R "$(dirname "$0")/rnaseq-de/." "$DEST/"

echo "Installed rnaseq-de to $DEST"
