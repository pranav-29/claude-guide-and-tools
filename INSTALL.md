# Install instructions for Claude

When a user gives you the link to this repository and asks you to install the
tools, follow these steps **exactly**. Do not improvise your own flow.

## Rules
- **Temp-clone inside `.claude`.** Clone this repo into a temporary folder under
  the user's Claude home: `~/.claude/tmp/frontend-tools-install`.
- **Clean up at the end.** Delete that temp clone once installation is done
  (success or failure).
- **Ask for the API key in chat.** Prompt the user for their `magic` (21st.dev)
  API key directly in the conversation. **Do NOT create a `.env` file.** Use the
  key only as an inline argument to the `claude mcp add` command.
- Never write the key to disk or commit it anywhere.

## Steps

1. **Temp clone** (replace `<REPO_URL>` with the link the user gave):
   ```bash
   rm -rf ~/.claude/tmp/frontend-tools-install
   git clone --depth 1 <REPO_URL> ~/.claude/tmp/frontend-tools-install
   ```

2. **Install the `ui-ux-pro-max` skill** (global, like its own installer does):
   ```bash
   npm install -g ui-ux-pro-max-cli
   uipro init --ai claude --global
   ```

3. **Ask the user in chat:** "Please paste your magic (21st.dev) API key."
   Wait for their reply.

4. **Add the `magic` MCP server** using the key they pasted (inline, no file):
   ```bash
   claude mcp add magic --scope user --env API_KEY="<KEY_FROM_CHAT>" -- npx -y @21st-dev/magic@latest
   ```

5. **Verify:**
   ```bash
   claude mcp list
   ```

6. **Delete the temp clone:**
   ```bash
   rm -rf ~/.claude/tmp/frontend-tools-install
   ```

7. Tell the user both tools are installed and the temp clone was removed.
