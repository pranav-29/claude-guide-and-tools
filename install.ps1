# Manual installer for frontend tools/skills (Windows / PowerShell)
# Prompts for the magic API key in the terminal. No .env file is created.
$ErrorActionPreference = "Stop"

# --- Get the API key (prompt only) ---------------------------------------
if (-not $env:MAGIC_API_KEY) {
    $env:MAGIC_API_KEY = Read-Host "Enter your magic (21st.dev) API key"
}

if (-not $env:MAGIC_API_KEY) {
    Write-Error "ERROR: No API key provided."
    exit 1
}

Write-Host "==> Frontend tools installer"

# --- 1. ui-ux-pro-max skill (project scope, into ./.claude/skills/) -------
Write-Host "==> Installing ui-ux-pro-max skill (current project)"
npx -y ui-ux-pro-max-cli init --ai claude

# --- 2. graphify (CLI + skill + always-on Claude integration) ------------
Write-Host "==> Installing graphify (CLI + Claude Code skill)"
if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv tool install graphifyy
} elseif (Get-Command pipx -ErrorAction SilentlyContinue) {
    pipx install graphifyy
} else {
    pip install graphifyy
}
# Project-scoped, always-on Claude integration: adds a CLAUDE.md directive +
# PreToolUse hook in THIS project so Claude consults the knowledge graph before
# every Glob/Grep. Writes only to the current project — no global ~/.claude.
# (We intentionally skip the global `graphify install` skill registration.)
graphify claude install

# --- 3. magic MCP server (local scope — current project only) -------------
Write-Host "==> Adding the 'magic' MCP server to Claude Code (local scope)"
claude mcp add magic --scope local --env API_KEY="$env:MAGIC_API_KEY" -- npx -y "@21st-dev/magic@latest"

Write-Host "==> Tools installed (project scope)."

# --- 4. Auto-build the knowledge graph for the current project ------------
# Code-only corpora need no API key (parsed locally via tree-sitter).
Write-Host "==> Building knowledge graph for the current project (graphify .)"
graphify .

Write-Host "==> Done. Graph built: graph.html / GRAPH_REPORT.md / graph.json"
