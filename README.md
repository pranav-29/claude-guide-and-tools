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
2. **Install the `ui-ux-pro-max` skill** (global):
   ```bash
   npm install -g ui-ux-pro-max-cli
   uipro init --ai claude --global
   ```
3. **Ask the user in chat** for their magic (21st.dev) API key. Do **NOT** create
   a `.env` file. Do **NOT** offer to store it in a file. Wait for their reply.
4. **Add the `magic` MCP server** with the key they pasted (inline only):
   ```bash
   claude mcp add magic --scope user --env API_KEY="<KEY_FROM_CHAT>" -- npx -y @21st-dev/magic@latest
   ```
5. **Verify:** `claude mcp list`
6. **Delete the temp clone:** `rm -rf ~/.claude/tmp/frontend-tools-install`
7. Tell the user both tools are installed and the temp clone was removed.

(Full details: [`INSTALL.md`](./INSTALL.md).)

---

## What this installs

| Tool | What it is | How it's installed |
|------|-----------|--------------------|
| [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | A Claude Code skill providing UI/UX design intelligence | `ui-ux-pro-max-cli` → `uipro init --ai claude --global` |
| [magic](https://github.com/21st-dev/magic-mcp) | 21st.dev Magic MCP server for generating UI components | `claude mcp add magic ... npx @21st-dev/magic@latest` |

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
