#!/usr/bin/env bash
# Manual installer for frontend tools/skills (macOS / Linux / Git Bash)
# Prompts for the magic API key in the terminal. No .env file is created.
set -euo pipefail

# --- Get the API key (prompt only) ---------------------------------------
if [ -z "${MAGIC_API_KEY:-}" ]; then
  printf "Enter your magic (21st.dev) API key: "
  read -r MAGIC_API_KEY
fi

if [ -z "${MAGIC_API_KEY:-}" ]; then
  echo "ERROR: No API key provided." >&2
  exit 1
fi

echo "==> Frontend tools installer"

# --- 1. ui-ux-pro-max skill ----------------------------------------------
echo "==> Installing ui-ux-pro-max skill (global, Claude Code)"
npm install -g ui-ux-pro-max-cli
uipro init --ai claude --global

# --- 2. magic MCP server --------------------------------------------------
echo "==> Adding the 'magic' MCP server to Claude Code (user scope)"
claude mcp add magic --scope user \
  --env API_KEY="$MAGIC_API_KEY" \
  -- npx -y @21st-dev/magic@latest

echo "==> Done. Tools installed."
