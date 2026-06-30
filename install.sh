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

# --- 1. ui-ux-pro-max skill (project scope, into ./.claude/skills/) -------
echo "==> Installing ui-ux-pro-max skill (current project)"
npx -y ui-ux-pro-max-cli init --ai claude

# --- 2. graphify (CLI + skill + always-on Claude integration) ------------
echo "==> Installing graphify (CLI + Claude Code skill)"
if command -v uv >/dev/null 2>&1; then
  uv tool install graphifyy
elif command -v pipx >/dev/null 2>&1; then
  pipx install graphifyy
else
  pip install graphifyy
fi
# Register the /graphify skill
graphify install
# Always-on Claude Code integration: adds CLAUDE.md directive + PreToolUse hook
# so Claude consults the knowledge graph before every Glob/Grep (project scope).
graphify claude install

# --- 3. magic MCP server (local scope — current project only) -------------
echo "==> Adding the 'magic' MCP server to Claude Code (local scope)"
claude mcp add magic --scope local \
  --env API_KEY="$MAGIC_API_KEY" \
  -- npx -y @21st-dev/magic@latest

echo "==> Done. Tools installed."
echo "==> Tip: graphify is installed. Run '/graphify .' inside a project to build its graph."
