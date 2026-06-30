<!-- ════════════════════════════════════════════════════════════════════
     🤖 INSTRUCTIONS FOR CLAUDE — read this BEFORE doing anything.
     If a user gives you this repo link and asks to install it, you MUST
     follow these exact steps. Do not improvise. Do not clone into the
     current working directory. Do not create or mention a .env file.
     ════════════════════════════════════════════════════════════════════ -->

# Frontend Tools / Skills Installer

## 🤖 Instructions for Claude (follow exactly)

When asked to install this repo, do **all** of the following, in order:

1. **Temp-clone into `.claude`** (NOT the current directory):
   ```bash
   rm -rf ~/.claude/tmp/frontend-tools-install
   git clone --depth 1 https://github.com/pranav-29/claude-guide-and-tools.git ~/.claude/tmp/frontend-tools-install
   ```
2. **Install the `ui-ux-pro-max` skill** — project scope, **not global**:
   ```bash
   npx -y ui-ux-pro-max-cli init --ai claude
   ```
3. **Install `graphify`** (CLI + skill, no key) + always-on Claude integration:
   ```bash
   uv tool install graphifyy   # or: pipx install graphifyy / pip install graphifyy
   graphify install            # register the /graphify skill
   graphify claude install     # CLAUDE.md directive + PreToolUse hook (always-on)
   ```
4. **Ask the user in chat** for their magic (21st.dev) API key. Do **NOT** create
   a `.env` file. Do **NOT** offer to store it in a file. Wait for their reply.
5. **Add the `magic` MCP server** — local scope, **not user/global** — inline only:
   ```bash
   claude mcp add magic --scope local --env API_KEY="<KEY_FROM_CHAT>" -- npx -y @21st-dev/magic@latest
   ```
6. **Verify:** `claude mcp list`
7. **Delete the temp clone:** `rm -rf ~/.claude/tmp/frontend-tools-install`
8. Tell the user all tools are installed, then **ask which folder to graph** and
   run `/graphify <path>` on it (or let them skip).

(Full details: [`INSTALL.md`](./INSTALL.md).)

---

## What this installs

| Tool | What it is | How it's installed |
|------|-----------|--------------------|
| [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | A Claude Code skill providing UI/UX design intelligence | `npx ui-ux-pro-max-cli init --ai claude` (project scope) |
| [graphify](https://github.com/safishamsi/graphify) | CLI + Claude Code skill that turns a codebase into a queryable knowledge graph | `uv tool install graphifyy` → `graphify install` → `graphify claude install` (always-on) |
| [magic](https://github.com/21st-dev/magic-mcp) | 21st.dev Magic MCP server for generating UI components | `claude mcp add magic --scope local ... npx @21st-dev/magic@latest` |

## Manual install (optional)

Both scripts **prompt for the API key** in the terminal — no `.env`, no file editing.

```powershell
./install.ps1     # Windows
```
```bash
chmod +x install.sh && ./install.sh   # macOS / Linux / Git Bash
```

## Prerequisites

- [Node.js / npm](https://nodejs.org/)
- [Claude Code](https://claude.com/claude-code) CLI (`claude` on your PATH)
- Python 3.x (used by the ui-ux-pro-max search script)

> 🔒 The API key is only ever passed inline to `claude mcp add` — never written to
> disk or committed.
