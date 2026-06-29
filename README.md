# Frontend Tools / Skills Installer

Automatically installs the frontend tooling I use with Claude Code:

| Tool | What it is | How it's installed |
|------|-----------|--------------------|
| [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | A Claude Code skill providing UI/UX design intelligence | `ui-ux-pro-max-cli` → `uipro init --ai claude --global` |
| [magic](https://github.com/21st-dev/magic-mcp) | 21st.dev Magic MCP server for generating UI components | `claude mcp add magic ... npx @21st-dev/magic@latest` |

## Prerequisites

- [Node.js / npm](https://nodejs.org/)
- [Claude Code](https://claude.com/claude-code) CLI (`claude` on your PATH)
- Python 3.x (used by the ui-ux-pro-max search script)

## Configuration

The `magic` MCP server needs an API key, read **only** from a `.env` file
(which is gitignored and never committed). Set it up first:

```bash
cp .env.example .env      # Windows: Copy-Item .env.example .env
```

Then edit `.env` and set your real key:

```
MAGIC_API_KEY=your-magic-api-key-here
```

## Usage

### Windows (PowerShell)

```powershell
git clone <this-repo-url>
cd <repo>
Copy-Item .env.example .env   # then edit .env with your key
./install.ps1
```

### macOS / Linux / Git Bash

```bash
git clone <this-repo-url>
cd <repo>
cp .env.example .env          # then edit .env with your key
chmod +x install.sh
./install.sh
```

> ⚠️ **Security note:** The API key lives only in `.env`, which is gitignored.
> Only `.env.example` (a placeholder) is committed to GitHub.
