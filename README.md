# Frontend Tools / Skills Installer

Installs the frontend tooling I use with Claude Code:

| Tool | What it is | How it's installed |
|------|-----------|--------------------|
| [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | A Claude Code skill providing UI/UX design intelligence | `ui-ux-pro-max-cli` → `uipro init --ai claude --global` |
| [magic](https://github.com/21st-dev/magic-mcp) | 21st.dev Magic MCP server for generating UI components | `claude mcp add magic ... npx @21st-dev/magic@latest` |

## Recommended: let Claude install it

Just give Claude this repo link and say **"install the tools from this repo."**
Claude follows [`INSTALL.md`](./INSTALL.md), which makes it:

1. Temp-clone this repo into `~/.claude/tmp/frontend-tools-install`.
2. Install the `ui-ux-pro-max` skill globally.
3. **Ask you for the magic API key in chat** (no `.env` file is created).
4. Add the `magic` MCP server using that key.
5. Delete the temp clone when done.

## Manual install (optional)

Both scripts **prompt for the API key** in the terminal — no file editing, no `.env`.

```powershell
# Windows
./install.ps1
```

```bash
# macOS / Linux / Git Bash
chmod +x install.sh
./install.sh
```

## Prerequisites

- [Node.js / npm](https://nodejs.org/)
- [Claude Code](https://claude.com/claude-code) CLI (`claude` on your PATH)
- Python 3.x (used by the ui-ux-pro-max search script)

> 🔒 The API key is only ever passed inline to `claude mcp add` and is never
> written to disk or committed.
