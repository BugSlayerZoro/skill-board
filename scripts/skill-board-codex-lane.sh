#!/usr/bin/env bash
# Compatibility shim: the Codex lane is skill-board-lane.sh --backend codex (same flags).
exec bash "$(dirname "${BASH_SOURCE[0]}")/skill-board-lane.sh" --backend codex "$@"
