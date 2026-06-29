# Auto-installer for frontend tools/skills (Windows / PowerShell)
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

# --- Get the API key ------------------------------------------------------
# Priority: existing env var > .env file > interactive prompt.
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#") -and $line.Contains("=")) {
            $name, $value = $line -split "=", 2
            Set-Item -Path "Env:$($name.Trim())" -Value $value.Trim()
        }
    }
}

if (-not $env:MAGIC_API_KEY -or $env:MAGIC_API_KEY -eq "your-magic-api-key-here") {
    $env:MAGIC_API_KEY = Read-Host "Enter your magic (21st.dev) API key"
}

if (-not $env:MAGIC_API_KEY) {
    Write-Error "ERROR: No API key provided."
    exit 1
}

Write-Host "==> Frontend tools installer"

# --- 1. ui-ux-pro-max skill ----------------------------------------------
Write-Host "==> Installing ui-ux-pro-max skill (global, Claude Code)"
npm install -g ui-ux-pro-max-cli
uipro init --ai claude --global

# --- 2. magic MCP server --------------------------------------------------
Write-Host "==> Adding the 'magic' MCP server to Claude Code (user scope)"
claude mcp add magic --scope user --env API_KEY="$env:MAGIC_API_KEY" -- npx -y "@21st-dev/magic@latest"

Write-Host "==> Done. Tools installed."
