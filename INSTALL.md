# Install instructions for Claude

When a user gives you the link to this repository and asks you to install the
tools, follow these steps **exactly**. Do not improvise your own flow.

## Rules

- **Everything is PROJECT-scoped, never global.** All install commands must run
  in the **user's current project directory** so they land in that project's
  `./.claude/` / `./CLAUDE.md` — never in the global `~/.claude`. The temp clone
  below is ONLY for reading these instructions; do NOT run installs inside it.
- **Temp-clone inside `.claude`.** Clone this repo into a temporary folder under
  the user's Claude home: `~/.claude/tmp/frontend-tools-install`.
- **Clean up at the end.** Delete that temp clone once installation is done
  (success or failure).
- **Ask for the magic API key in chat.** Prompt the user for their `magic`
  (21st.dev) API key directly in the conversation. **Do NOT create a `.env`
  file.** Use the key only as an inline argument to `claude mcp add`.
- Never write any key to disk or commit it anywhere.

## Steps

1. **Temp clone:**

   ```bash
   rm -rf ~/.claude/tmp/frontend-tools-install
   git clone --depth 1 https://github.com/pranav-29/claude-guide-and-tools.git ~/.claude/tmp/frontend-tools-install
   ```
2. **Install the `ui-ux-pro-max` skill** — **project scope, NOT global**
   (lands in the current project's `./.claude/skills/`):

   ```bash
   npx -y ui-ux-pro-max-cli init --ai claude
   ```
3. **Install `graphify`** (CLI, no API key), then wire up the **project-scoped**
   always-on Claude integration. Run `graphify claude install` from **inside the
   user's project** so it writes to that project only:

   ```bash
   uv tool install graphifyy   # fallback: pipx install graphifyy  OR  pip install graphifyy
   graphify claude install     # project ./CLAUDE.md directive + PreToolUse hook
   ```

   `graphify claude install` makes Claude Code actually *use* the graph — it adds a
   `CLAUDE.md` directive plus a PreToolUse hook (in THIS project) so Claude consults
   the knowledge graph before every Glob/Grep.
   **Do NOT run the global `graphify install`** — that registers the skill in the
   global `~/.claude`, which the user does not want.
4. **Ask the user in chat:** "Please paste your magic (21st.dev) API key."
   Wait for their reply.
5. **Add the `magic` MCP server** — **local scope, NOT user/global** — using the
   key they pasted (inline, no file):

   ```bash
   claude mcp add magic --scope local --env API_KEY="<KEY_FROM_CHAT>" -- npx -y @21st-dev/magic@latest
   ```
6. **Verify:**

   ```bash
   claude mcp list
   ```
7. **Delete the temp clone:**

   ```bash
   rm -rf ~/.claude/tmp/frontend-tools-install
   ```
8. **Auto-graph step.** After cleanup, tell the user all tools are installed
   (project scope), then **ask:** "graphify is ready — kis project/folder ka graph
   banau? (path batao, ya 'skip' bolo)". If they give a path, build the graph by
   running the **graphify CLI** on it:

   ```bash
   graphify <path>      # e.g. graphify .   → produces graph.html, GRAPH_REPORT.md, graph.json
   ```

   (We use the `graphify` CLI directly, not a `/graphify` slash command, since the
   global skill was intentionally not registered.) If they say skip, remind them
   they can run `graphify .` in the project anytime.

