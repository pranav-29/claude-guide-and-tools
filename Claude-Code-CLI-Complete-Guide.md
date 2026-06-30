# Claude Code CLI — Complete Guide

> Everything you need to use Claude Code from the command line: installation, every CLI command and flag, every in-session slash command, keyboard shortcuts, memory files, settings, hooks, MCP, subagents, skills, permissions, and more.
>
> _Last updated: June 2026_

---

## Table of Contents

1. [Installation & System Requirements](#1-installation--system-requirements)
2. [CLI Commands (shell-level)](#2-cli-commands-shell-level)
3. [CLI Flags](#3-cli-flags)
4. [Interactive / Slash Commands](#4-interactive--slash-commands)
5. [Keyboard Shortcuts & Input Modes](#5-keyboard-shortcuts--input-modes)
6. [CLAUDE.md Memory Files](#6-claudemd-memory-files)
7. [settings.json & Configuration](#7-settingsjson--configuration)
8. [Permission Modes](#8-permission-modes)
9. [Hooks](#9-hooks)
10. [MCP (Model Context Protocol)](#10-mcp-model-context-protocol)
11. [Subagents & Custom Agents](#11-subagents--custom-agents)
12. [Skills & Custom Commands](#12-skills--custom-commands)
13. [Plan Mode](#13-plan-mode)
14. [Headless / Print Mode](#14-headless--print-mode)
15. [Environment Variables](#15-environment-variables)
16. [Directory Structure & File Locations](#16-directory-structure--file-locations)
17. [Common Workflows / Quick Recipes](#17-common-workflows--quick-recipes)

---

## 1. Installation & System Requirements

### System Requirements
- **OS**: macOS 13.0+, Windows 10 1809+ / Server 2019+, Ubuntu 20.04+, Debian 10+, Alpine Linux 3.19+
- **Hardware**: 4 GB+ RAM, x64 or ARM64 processor
- **Network**: Internet connection required
- **Shell**: Bash, Zsh, PowerShell, or CMD
- **Region**: Anthropic-supported countries only

### Installation Methods

**Native install (recommended)**
```bash
# macOS / Linux / WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex

# Windows CMD
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

**Homebrew (macOS / Linux)**
```bash
brew install --cask claude-code            # stable channel
brew install --cask claude-code@latest     # latest channel
brew upgrade claude-code                   # update
```

**WinGet (Windows)**
```powershell
winget install Anthropic.ClaudeCode
winget upgrade Anthropic.ClaudeCode
```

**Linux package managers**
```bash
sudo apt install claude-code   # Debian/Ubuntu
sudo dnf install claude-code   # Fedora/RHEL
apk add claude-code            # Alpine
```

**npm (Node.js 18+)**
```bash
npm install -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code@latest   # update
```

**Specific version**
```bash
curl -fsSL https://claude.ai/install.sh | bash -s 2.1.89
curl -fsSL https://claude.ai/install.sh | bash -s stable
```

---

## 2. CLI Commands (shell-level)

### Session management
| Command | Description |
|---------|-------------|
| `claude` | Start an interactive session |
| `claude "query"` | Start with an initial prompt |
| `claude -p "query"` | Print mode: answer and exit |
| `cat file \| claude -p "query"` | Process piped content |
| `claude -c` | Continue the most recent session |
| `claude -c -p "query"` | Continue in print mode |
| `claude -r "<session>"` | Resume session by ID/name |
| `claude -r` | Interactive session picker |

### Updates & installation
| Command | Description |
|---------|-------------|
| `claude update` | Update to latest version |
| `claude install [version]` | Install/reinstall binary |
| `claude install stable` | Install stable release |
| `claude install latest` | Install latest release |
| `claude install 2.1.89` | Install a specific version |

### Authentication
| Command | Description |
|---------|-------------|
| `claude auth login` | Sign in |
| `claude auth login --email user@example.com` | Pre-fill email |
| `claude auth login --sso` | Force SSO authentication |
| `claude auth login --console` | Console / API key login |
| `claude auth logout` | Sign out |
| `claude auth status` | Auth status as JSON |
| `claude auth status --text` | Human-readable auth status |
| `claude setup-token` | Generate a long-lived OAuth token |

### Background sessions & agent view
| Command | Description |
|---------|-------------|
| `claude agents` | Open agent view for parallel sessions |
| `claude agents --json` | List sessions as JSON |
| `claude agents --json --all` | Include completed sessions |
| `claude agents --cwd <path>` | Filter by directory |
| `claude attach <id>` | Attach to a background session |
| `claude stop <id>` | Stop a background session |
| `claude kill <id>` | Alias for `claude stop` |
| `claude rm <id>` | Remove session from list |
| `claude respawn <id>` | Restart a session |
| `claude respawn --all` | Restart all sessions |
| `claude logs <id>` | Print a session's output |
| `claude daemon status` | Show supervisor state |
| `claude daemon stop --any` | Stop supervisor & sessions |
| `claude daemon stop --any --keep-workers` | Stop supervisor, keep sessions |

### MCP, plugins & config
| Command | Description |
|---------|-------------|
| `claude mcp` | Configure MCP servers |
| `claude mcp login <name>` | Run OAuth flow for an MCP server |
| `claude mcp logout <name>` | Clear MCP server credentials |
| `claude plugin` / `claude plugins` | Manage plugins |
| `claude plugin install <plugin>` | Install a plugin |
| `claude config` | Open the interactive settings UI |

### Utilities
| Command | Description |
|---------|-------------|
| `claude --version` / `claude -v` | Show version |
| `claude doctor` | Diagnose installation issues |
| `claude auto-mode defaults` | Print auto-mode classifier rules |
| `claude auto-mode config` | Print effective auto-mode config |
| `claude ultrareview [target]` | Run a cloud-based code review |
| `claude project purge [path]` | Delete project state |
| `claude project purge --dry-run` | Preview deletion |
| `claude remote-control --name "My Project"` | Start a Remote Control server |

---

## 3. CLI Flags

These modify a session's behavior when starting `claude`.

### Essentials
| Flag | Description |
|------|-------------|
| `--model <model>` | Set the AI model (`sonnet`, `opus`, `haiku`, `fable`, or full ID) |
| `--effort <level>` | Reasoning effort: `low`, `medium`, `high`, `xhigh`, `max` |
| `--permission-mode <mode>` | Start in a permission mode |
| `--name <name>` / `-n` | Name the session |

### Model & reasoning
| Flag | Description |
|------|-------------|
| `--model sonnet\|opus\|haiku\|fable` | Use a model alias |
| `--model claude-sonnet-4-6` | Use a full model ID |
| `--fallback-model sonnet,haiku` | Fallback chain on overload |
| `--advisor <model>` | Enable advisor tool with a model |
| `--fast on` / `--fast off` | Toggle fast mode |

### Effort & budget
| Flag | Description |
|------|-------------|
| `--effort low\|medium\|high\|xhigh\|max` | Adjust reasoning level |
| `--max-turns 3` | Limit agentic turns |
| `--max-budget-usd 5.00` | Stop when budget reached |

### Permissions & security
| Flag | Description |
|------|-------------|
| `--permission-mode default` | Ask for every action |
| `--permission-mode acceptEdits` | Auto-approve file edits |
| `--permission-mode plan` | Plan before editing |
| `--permission-mode auto` | Auto-approve with safety checks |
| `--permission-mode dontAsk` | Only allow pre-approved tools |
| `--permission-mode bypassPermissions` | Skip all checks (isolated environments only!) |
| `--dangerously-skip-permissions` | Alias for bypass mode |
| `--allow-dangerously-skip-permissions` | Add bypass to the Shift+Tab cycle |
| `--allowedTools "Bash(npm test)" "Read"` | Pre-approve tools |
| `--disallowedTools "Bash(rm *)" "Edit"` | Deny specific tools |
| `--tools "Bash,Edit,Read"` | Restrict built-in tools |
| `--tools ""` | Disable all tools |

### Context & memory
| Flag | Description |
|------|-------------|
| `--add-dir ../lib ../apps` | Grant access to extra directories |
| `--setting-sources user,project` | Load specific settings sources |
| `--settings ./custom-settings.json` | Override settings file |
| `--bare` | Minimal mode: skip hooks/skills/MCP |
| `--safe-mode` | Disable customizations, keep auth |
| `--exclude-dynamic-system-prompt-sections` | Improve cache reuse |

### System prompt
| Flag | Description |
|------|-------------|
| `--system-prompt "You are..."` | Replace the entire system prompt |
| `--system-prompt-file ./prompt.txt` | Load system prompt from file |
| `--append-system-prompt "Always..."` | Append to default prompt |
| `--append-system-prompt-file ./rules.txt` | Append from file |

### Output & format
| Flag | Description |
|------|-------------|
| `--print` / `-p` | Print mode (exit after response) |
| `--output-format text\|json\|stream-json` | Output format |
| `--input-format stream-json` | Accept streaming JSON input |
| `--verbose` | Show full turn-by-turn output |
| `--json-schema '{...}'` | Validate output against a JSON schema |
| `--prompt-suggestions` | Emit prompt suggestions (needs `--print --output-format stream-json --verbose`) |

### Remote & web
| Flag | Description |
|------|-------------|
| `--remote "Fix the bug"` | Create a web session on claude.ai |
| `--remote-control` / `--rc` | Enable Remote Control |
| `--teleport` | Resume a web session in the terminal |

### Worktrees & parallel work
| Flag | Description |
|------|-------------|
| `--worktree` / `-w <name>` | Create an isolated git worktree |
| `--worktree #123` | Branch from PR #123 |
| `--tmux` | Create a tmux session (with worktree) |
| `--tmux=classic` | Use classic tmux |
| `--background` / `--bg` | Start as a background session |
| `--fork-session` | Fork the session when resuming |

### Hooks & agents
| Flag | Description |
|------|-------------|
| `--init` | Run Setup hooks before the session |
| `--init-only` | Run Setup hooks and exit |
| `--maintenance` | Run maintenance hooks before the session |
| `--agent <name>` | Use a specific subagent |
| `--agents '{...}'` | Define subagents dynamically (JSON) |

### MCP & plugins
| Flag | Description |
|------|-------------|
| `--mcp-config ./mcp.json` | Load MCP from a file |
| `--strict-mcp-config` | Only use specified MCP servers |
| `--plugin-dir ./my-plugin` | Load a plugin from a directory |
| `--plugin-url https://.../plugin.zip` | Fetch a plugin from a URL |

### Other useful flags
| Flag | Description |
|------|-------------|
| `--continue` / `-c` | Continue recent session |
| `--from-pr 123` | Resume sessions for PR #123 |
| `--no-session-persistence` | Don't save session to disk |
| `--session-id <uuid>` | Use a specific session ID |
| `--ide` | Auto-connect to IDE |
| `--debug [category]` | Enable debug logging |
| `--debug-file /tmp/debug.log` | Write debug logs to file |
| `--chrome` / `--no-chrome` | Toggle Chrome integration |
| `--betas interleaved-thinking` | Enable beta API features |
| `--ax-screen-reader` | Screen-reader-friendly output |

---

## 4. Interactive / Slash Commands

Type these inside a running `claude` session.

### Session management
| Command | Purpose |
|---------|---------|
| `/clear [name]` | Start a new conversation, label the old one |
| `/reset`, `/new` | Aliases for `/clear` |
| `/resume [session]` | Resume a conversation by ID/name |
| `/continue` | Alias for `/resume` |
| `/branch [name]` | Fork the current conversation |
| `/fork <directive>` | Spawn a forked subagent |
| `/rename [name]` | Rename the current session |
| `/export [filename]` | Export the conversation to a file |
| `/background [prompt]`, `/bg` | Detach the session and run in background |
| `/exit`, `/quit` | Exit Claude Code |

### Configuration & settings
| Command | Purpose |
|---------|---------|
| `/config [key=value]` | Open Settings UI or set a value directly |
| `/settings` | Alias for `/config` |
| `/config theme=dark` | Set theme via shorthand |
| `/config model=sonnet` | Set model via shorthand |
| `/model [model]` | Switch the AI model |
| `/effort [level\|auto]` | Set reasoning effort |
| `/advisor [model\|off]` | Enable/disable the advisor tool |
| `/fast [on\|off]` | Toggle fast mode |
| `/theme` | Change color theme |
| `/tui [default\|fullscreen]` | Switch terminal renderer |
| `/statusline` | Configure the status line |
| `/terminal-setup` | Set up Shift+Enter shortcuts |
| `/keybindings` | Open keyboard shortcuts file |

### Project setup
| Command | Purpose |
|---------|---------|
| `/init` | Generate an initial CLAUDE.md |
| `/memory` | View/edit CLAUDE.md, toggle auto memory |
| `/agents` | Manage subagent configurations |
| `/mcp [subcommand]` | Manage MCP servers |
| `/mcp reconnect <server>` | Reconnect an MCP server |
| `/mcp enable\|disable <server>\|all` | Toggle MCP server(s) |
| `/permissions` | Manage allow/deny rules |
| `/allowed-tools` | Alias for `/permissions` |
| `/hooks` | View hook configurations |
| `/plugin [subcommand]` | Manage plugins |
| `/skills` | List available skills |
| `/reload-plugins [--force]` | Reload plugins |
| `/reload-skills` | Rescan skill directories |

### Work organization
| Command | Purpose |
|---------|---------|
| `/plan [description]` | Enter plan mode |
| `/context [all]` | Visualize context usage |
| `/compact [instructions]` | Summarize the conversation, free up context |
| `/rewind`, `/checkpoint`, `/undo` | Roll back to a previous state |
| `/diff` | View an interactive diff |
| `/tasks`, `/bashes` | View background tasks |
| `/add-dir <path>` | Add a working directory |
| `/cd <path>` | Move to a new directory |

### Code review & quality
| Command | Purpose |
|---------|---------|
| `/code-review [level] [--fix] [--comment] [target]` | Review a diff (levels: low/medium/high/xhigh/max/ultra) |
| `/simplify [target]` | Cleanup review without bug hunting |
| `/review [PR]` | Review a GitHub PR |
| `/security-review` | Analyze changes for security issues |
| `/run` | Launch and verify the app |
| `/verify` | Confirm a code change works |

### Automation & orchestration
| Command | Purpose |
|---------|---------|
| `/batch <instruction>` | Parallel changes across the codebase |
| `/loop [interval] [prompt]` | Run a prompt repeatedly |
| `/goal [condition\|clear]` | Set a goal for continuous work |
| `/schedule [description]` | Create a scheduled routine |
| `/autofix-pr [prompt]` | Watch a PR and auto-fix |
| `/workflows` | View workflow progress |

### Debugging & diagnostics
| Command | Purpose |
|---------|---------|
| `/debug [description]` | Enable debug logging |
| `/doctor` | Diagnose installation |
| `/feedback [report]`, `/bug`, `/share` | Report a bug or share |
| `/heapdump` | Write a memory snapshot |

### Utilities & integration
| Command | Purpose |
|---------|---------|
| `/help` | Show available commands |
| `/copy [N]` | Copy the last (or Nth) response to clipboard |
| `/btw <question>` | Ask a side question (no tools) |
| `/recap` | Generate a session summary |
| `/usage`, `/cost`, `/stats` | Show costs and usage |
| `/insights` | Analyze session patterns |
| `/login`, `/logout` | Sign in / out |
| `/ide` | Manage IDE integration |
| `/chrome` | Configure Chrome settings |
| `/remote-control`, `/rc` | Enable Remote Control |
| `/teleport`, `/tp` | Pull a web session to the terminal |
| `/install-github-app` | Set up GitHub integration |
| `/release-notes` | View the changelog |

### Advanced
| Command | Purpose |
|---------|---------|
| `/deep-research <question>` | Fan-out research with synthesis |
| `/ultraplan <prompt>` | Draft a plan in the browser, then execute |
| `/ultrareview [PR]` | Cloud-based deep review |
| `/fewer-permission-prompts` | Auto-configure an allowlist |
| `/sandbox` | Toggle sandbox mode |
| `/setup-bedrock` | Configure Amazon Bedrock |
| `/setup-vertex` | Configure Google Vertex AI |

---

## 5. Keyboard Shortcuts & Input Modes

### General controls
| Shortcut | Action |
|----------|--------|
| `Ctrl+C` | Interrupt or clear input; press twice to exit |
| `Ctrl+D` | Exit Claude Code |
| `Ctrl+L` | Redraw the screen |
| `Ctrl+O` | Toggle the transcript viewer |
| `Ctrl+R` | Reverse-search command history |
| `Ctrl+V` | Paste an image from clipboard |
| `Ctrl+B` | Background running tasks |
| `Ctrl+T` | Toggle the task list |
| `Ctrl+G` or `Ctrl+X Ctrl+E` | Open the prompt in a text editor |
| `Ctrl+X Ctrl+K` | Stop all background subagents (press twice) |

### Navigation
| Shortcut | Action |
|----------|--------|
| `Up/Down` or `Ctrl+P`/`Ctrl+N` | Navigate command history |
| `Left/Right` | Cycle through dialog tabs |
| `Esc` | Interrupt Claude's response |
| `Esc` `Esc` | Clear input or open the rewind menu |

### Mode cycling
| Shortcut | Action |
|----------|--------|
| `Shift+Tab` or `Alt+M` | Cycle permission modes (default → acceptEdits → plan → …) |
| `Option/Alt+P` | Switch model |
| `Option/Alt+T` | Toggle extended thinking |
| `Option/Alt+O` | Toggle fast mode |

### Text editing
| Shortcut | Action |
|----------|--------|
| `Ctrl+A` / `Ctrl+E` | Move to start / end of line |
| `Ctrl+K` | Delete to end of line |
| `Ctrl+U` | Delete to start of line |
| `Ctrl+W` | Delete previous word |
| `Ctrl+Y` | Paste deleted text |
| `Alt+Y` | Cycle paste history (after `Ctrl+Y`) |
| `Alt+B` / `Alt+F` | Move back / forward one word |

### Multiline input
| Method | Shortcut |
|--------|----------|
| Quick escape | `\` then `Enter` |
| Option key (macOS) | `Option+Enter` |
| Shift+Enter | `Shift+Enter` (most modern terminals; run `/terminal-setup` first) |
| Control sequence | `Ctrl+J` |

### Quick input prefixes
| Prefix | Action |
|--------|--------|
| `/` | Command / skill menu |
| `!` | Shell mode — run a command directly and feed output into context |
| `@` | Mention a file path |
| `#` | Add a note straight to memory (CLAUDE.md) |

### Transcript viewer (`Ctrl+O`)
| Shortcut | Action |
|----------|--------|
| `?` | Help panel (fullscreen only) |
| `Ctrl+E` | Toggle show-all-content |
| `{` / `}` | Jump to prev/next user prompt |
| `q` / `Esc` | Exit transcript view |

---

## 6. CLAUDE.md Memory Files

`CLAUDE.md` files give Claude persistent instructions and context, loaded automatically.

### Scope & location
| Scope | Location | Shared |
|-------|----------|--------|
| Managed policy | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS), `/etc/claude-code/CLAUDE.md` (Linux/WSL), `C:\Program Files\ClaudeCode\CLAUDE.md` (Windows) | Yes (IT deployed) |
| User | `~/.claude/CLAUDE.md` | No (you, all projects) |
| Project | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Yes (team via git) |
| Local | `./CLAUDE.local.md` | No (gitignored) |

### How it loads
1. Walks up the directory tree from the working directory.
2. Loads `CLAUDE.md` then `CLAUDE.local.md` from each directory (root → cwd).
3. Loads on-demand from subdirectories when Claude reads files in them.

### Features

**Imports** with `@path`:
```markdown
See @README for an overview and @package.json for commands.
@docs/git-instructions.md
```

**AGENTS.md compatibility:**
```markdown
@AGENTS.md

## Claude Code Specific
Use plan mode for src/billing/ changes.
```

**Path-specific rules** (in `.claude/rules/`):
```markdown
---
paths:
  - "src/api/**/*.ts"
  - "src/**/*.{ts,tsx}"
---
# API Development Rules
- Include input validation
- Use standard error responses
```

### Best practices
- Keep each file under ~200 lines.
- Be specific ("Use 2-space indentation," not "format properly").
- Use markdown headers/bullets for structure.
- Remove conflicting rules.
- Use skills for temporary, task-specific instructions instead.

---

## 7. settings.json & Configuration

### Hierarchy (highest priority first)
1. Managed settings (IT admin)
2. Command-line flags
3. Local settings — `.claude/settings.local.json`
4. Project settings — `.claude/settings.json`
5. User settings — `~/.claude/settings.json`

### Example
```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "model": "claude-sonnet-4-6",
  "effortLevel": "high",
  "autoUpdatesChannel": "latest",
  "permissions": {
    "defaultMode": "plan",
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test *)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl *)",
      "Read(./.env*)",
      "Read(./secrets/**)"
    ]
  },
  "env": {
    "LANG": "en_US.UTF-8",
    "DEBUG": "0"
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "npx prettier --write" }
        ]
      }
    ]
  }
}
```

### Common keys
```json
{
  "model": "claude-sonnet-4-6",
  "fallbackModel": "sonnet,haiku",
  "effortLevel": "medium",
  "alwaysThinkingEnabled": false,
  "advisorModel": "opus",

  "permissions": {
    "defaultMode": "acceptEdits",
    "allow": [],
    "deny": [],
    "ask": [],
    "additionalDirectories": ["/path/to/shared"]
  },

  "autoMemoryEnabled": true,
  "disableAllHooks": false,
  "respectGitignore": true,
  "fileCheckpointingEnabled": true,

  "theme": "dark-ansi",
  "editorMode": "vim",
  "viewMode": "compact",

  "env": { "ANTHROPIC_API_KEY": "sk-..." },
  "apiKeyHelper": "echo 'token-from-script'"
}
```

---

## 8. Permission Modes

| Mode | Auto-approves | Best for |
|------|---------------|----------|
| `default` | Reads only | Getting started, sensitive work |
| `acceptEdits` | Reads + file edits + safe FS ops (`mkdir`, `mv`, `cp`, …) | Iterating on code |
| `plan` | Reads only (proposes, doesn't apply) | Exploring before changing |
| `auto` | Everything, with a safety classifier | Long tasks, fewer interruptions |
| `dontAsk` | Only pre-approved tools | CI / locked-down environments |
| `bypassPermissions` | Everything, no safety checks | Isolated containers / VMs only |

**Switch during a session:** `Shift+Tab` to cycle.
**At startup:** `claude --permission-mode plan`.
**As default:** `"permissions": { "defaultMode": "acceptEdits" }`.

**Protected paths** are never auto-approved — e.g. `.git`, `.vscode`, `.idea`, `.claude` (except worktrees), `.gitconfig`, `.bashrc`, `.zshrc`, `.npmrc`, etc.

---

## 9. Hooks

Hooks run shell commands (or other actions) at specific lifecycle points.

### Common events
| Event | Fires when | Matches on |
|-------|------------|-----------|
| `SessionStart` | Session begins/resumes | startup, resume, clear, compact |
| `Setup` | `--init` / `--maintenance` | init, maintenance |
| `UserPromptSubmit` | User submits a prompt | — |
| `PreToolUse` | Before a tool runs | tool name |
| `PermissionRequest` | Before a permission prompt | tool name |
| `PostToolUse` | After a tool succeeds | tool name |
| `PostToolUseFailure` | After a tool fails | tool name |
| `Notification` | A notification is sent | permission_prompt, idle_prompt, … |
| `SubagentStart` / `SubagentStop` | Subagent lifecycle | agent type |
| `Stop` | Claude finishes responding | — |
| `SessionEnd` | Session terminates | clear, resume, logout, … |

### Hook types
`command` (shell), `http` (POST), `prompt` (single-turn LLM), `agent` (multi-turn with tools), `mcp_tool` (call an MCP tool).

### Exit codes
- `0` — continue normally.
- `2` — block the action; write the reason to stderr.
- other — proceed, log the error.

### Example
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "npx prettier --write", "timeout": 30 }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "permission_prompt",
        "hooks": [
          { "type": "command", "command": "notify-send 'Claude needs input'" }
        ]
      }
    ]
  }
}
```

---

## 10. MCP (Model Context Protocol)

MCP servers extend Claude with external tools and data.

### Scopes
| Scope | Location | Who sees it |
|-------|----------|-------------|
| Local | `.mcp.json` in project | This project |
| Project | `.mcp.json` in `.claude/` | Team via git |
| User | `~/.claude.json` | All your projects |

### Add servers
```bash
claude mcp add-http  sentry     https://api.sentry.io/mcp
claude mcp add-sse   github     https://github-mcp-server.example.com
claude mcp add-stdio postgresql ./pgsql-mcp-server
claude mcp add-ws    database   ws://localhost:3000
```

### `.mcp.json`
```json
{
  "mcpServers": {
    "github": { "command": "python3", "args": ["./github-mcp.py"], "type": "stdio" },
    "sentry": { "url": "https://sentry-mcp.example.com", "type": "http" },
    "database": { "url": "ws://localhost:3000", "type": "websocket" }
  }
}
```

### In-session
```
/mcp                       # interactive list
/mcp reconnect <server>    # reconnect
/mcp enable|disable <server>|all
claude mcp login <server>  # OAuth flow
```

---

## 11. Subagents & Custom Agents

Built-in: **Explore** (research), **Plan** (strategy), **general-purpose**. Custom agents live in `.claude/agents/`.

### Definition (`.claude/agents/code-reviewer.md`)
```markdown
---
name: "code-reviewer"
description: "Reviews code for bugs"
agent: "general-purpose"
model: "claude-opus-4-6"
permissions:
  allow:
    - "Read"
    - "Edit"
---
You are a code reviewer. Review the following code for bugs and suggest fixes.
```

### Commands
```
/agents                  # open the agent manager
/agents enable <agent>
/agents disable <agent>
/agent <name> <prompt>   # run a specific agent
```

---

## 12. Skills & Custom Commands

Skills are reusable, named prompt + tool bundles invoked as slash commands.

### A few bundled skills
`/run`, `/verify`, `/batch`, `/code-review`, `/simplify`, `/debug`, `/deep-research`, `/loop`, `/fewer-permission-prompts`, `/claude-api`.

### Create a custom skill (`.claude/skills/format-code.md`)
```markdown
---
name: format-code
actions:
  - format
  - prettier
description: "Auto-format code with Prettier"
---
Run prettier on the current project.

\`\`\`bash
npm run format
\`\`\`
```

---

## 13. Plan Mode

In plan mode Claude explores and proposes changes **without applying them**.

**Enter it:**
```bash
claude --permission-mode plan
# or in-session:
/plan <description>
# or cycle with Shift+Tab
```

When you approve a plan you can: start in auto mode, accept edits, review each edit individually, keep planning with feedback, or hand it to Ultraplan for browser review.

---

## 14. Headless / Print Mode

Run Claude non-interactively — great for scripts and CI.

```bash
claude -p "query"                          # answer and exit
claude -p "query" --output-format json     # JSON output
claude -p "query" --verbose                # full turn-by-turn
claude -p "query" --max-turns 3            # cap agentic turns
cat file | claude -p "summarize this"      # pipe content in
```

Combine with `--allowedTools`, `--permission-mode`, `--model`, and `--max-budget-usd` for controlled automation.

---

## 15. Environment Variables

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_API_KEY` | API key for authentication |
| `ANTHROPIC_MODEL` | Default model |
| `ANTHROPIC_BASE_URL` | Custom API endpoint |
| `CLAUDE_CODE_DEBUG_LOGS_DIR` | Debug log directory |
| `CLAUDE_CODE_DISABLE_AUTOUPDATER` | Disable auto-updates |
| `CLAUDE_CODE_DISABLE_AUTO_MEMORY` | Disable auto memory |
| `CLAUDE_CODE_ENABLE_AUTO_MODE` | Enable auto mode on Bedrock/Vertex/Foundry |
| `CLAUDE_CODE_GIT_BASH_PATH` | Path to Git Bash on Windows |
| `CLAUDE_CODE_USE_POWERSHELL_TOOL` | Use the PowerShell tool on Windows |
| `USE_BUILTIN_RIPGREP` | Use the builtin ripgrep (e.g. on Alpine) |

---

## 16. Directory Structure & File Locations

```
~/.claude/                         # User config directory
├── settings.json                  # User settings
├── CLAUDE.md                      # User instructions
├── rules/                         # User rules
├── agents/                        # User subagents
├── skills/                        # User skills
├── themes/                        # Custom themes
├── .claude.json                   # OAuth + MCP config
├── projects/                      # Per-project state
│   └── <project>/
│       ├── sessions/              # Session transcripts
│       ├── memory/                # Auto-memory
│       ├── state.json             # Project state
│       └── worktrees/             # Git worktrees
└── logs/                          # Debug logs

./.claude/                         # Project config directory
├── settings.json                  # Project settings
├── settings.local.json            # Local overrides (gitignored)
├── CLAUDE.md                      # Project instructions
├── rules/                         # Path-scoped rules
├── agents/                        # Project subagents
├── skills/                        # Project skills
└── hooks/                         # Hook scripts

./CLAUDE.md                        # Project instructions (root)
./CLAUDE.local.md                  # Local-only instructions (gitignored)
./.mcp.json                        # Project MCP config
```

---

## 17. Common Workflows / Quick Recipes

**Start a brand-new project setup:**
```bash
cd my-project
claude
> /init            # generate CLAUDE.md
> /memory          # review and edit it
```

**Plan a big change safely:**
```bash
claude --permission-mode plan "Refactor the auth module to use JWT"
# review the plan, then approve
```

**Fast one-off question from the shell:**
```bash
claude -p "What does this regex do? $(cat pattern.txt)"
```

**Review your uncommitted changes:**
```bash
claude
> /code-review high
```

**Run a script over the codebase in parallel:**
```bash
claude
> /batch Add JSDoc comments to every exported function
```

**Resume yesterday's session:**
```bash
claude -r            # pick from the list
# or
claude -c            # continue the most recent
```

**Work in an isolated worktree for a PR:**
```bash
claude --worktree feature-auth "Implement the login form"
```

**Reduce permission prompts for trusted commands:**
```bash
claude
> /fewer-permission-prompts
```

---

_This guide reflects Claude Code CLI as documented through June 2026. Commands and flags evolve — run `claude --help`, `/help`, or `claude doctor` for the most current list on your installed version._
