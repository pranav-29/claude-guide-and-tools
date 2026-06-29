# Install instructions for Claude

If a user gives you this repository and asks you to install the tools, do the
following:

1. **Ask the user for their `magic` (21st.dev) API key.** Do not proceed without it.
   Do not commit the key anywhere.

2. **Install the `ui-ux-pro-max` skill** (global, Claude Code):
   ```bash
   npm install -g ui-ux-pro-max-cli
   uipro init --ai claude --global
   ```

3. **Add the `magic` MCP server** (substitute the key the user gave you):
   ```bash
   claude mcp add magic --scope user --env API_KEY="<USER_API_KEY>" -- npx -y @21st-dev/magic@latest
   ```

4. Confirm both installed:
   ```bash
   claude mcp list
   ```

Alternatively, the user can just run `./install.sh` (macOS/Linux) or
`./install.ps1` (Windows) — both scripts will **prompt for the API key**
automatically if it isn't already set.
