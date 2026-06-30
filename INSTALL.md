# Install instructions for Claude

When a user gives you the link to this repository and asks you to install the
tools, follow these steps **exactly**. Do not improvise your own flow.

## Rules

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
3. **Install `graphify`** (CLI + skill, no API key), then wire up the always-on
   Claude Code integration:

   ```bash
   uv tool install graphifyy   # fallback: pipx install graphifyy  OR  pip install graphifyy
   graphify install            # register the /graphify skill
   graphify claude install     # always-on: adds CLAUDE.md directive + PreToolUse hook
   ```

   `graphify claude install` makes Claude Code actually *use* the graph — it adds a
   `CLAUDE.md` directive plus a PreToolUse hook so Claude consults the knowledge
   graph before every Glob/Grep. Run it from inside the user's project.
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
8. **Auto-graph step.** After cleanup, tell the user all tools are installed,
   then **ask:** "graphify is ready — kis project/folder ka graph banau? (path
   batao, ya 'skip' bolo)". If they give a path, build the graph by running the
   `/graphify <path>` skill on it (this produces `graph.html`,
   `GRAPH_REPORT.md`, and `graph.json`). If they say skip, just remind them they
   can run `/graphify .` anytime inside a project.

