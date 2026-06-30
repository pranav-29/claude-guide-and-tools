# How to Work with Claude Code: Best Practices & Workflows

> **Complete guide** showing how to combine built-in tools, skills, and MCP servers for maximum productivity across all development tasks.
>
> _Based on 2026 research + real-world workflows_

---

## Table of Contents

1. [Understanding the Three Pillars](#1-understanding-the-three-pillars)
2. [Essential Setup (First 10 Minutes)](#2-essential-setup-first-10-minutes)
3. [Token-Efficient Workflows](#3-token-efficient-workflows)
4. [Frontend/UI Development](#4-frontendui-development)
5. [Backend Development](#5-backend-development)
6. [Full-Stack MERN + Next.js](#6-full-stack-mern--nextjs)
7. [Database Work](#7-database-work)
8. [DevOps &amp; Infrastructure](#8-devops--infrastructure)
9. [AI/ML Development](#9-aiml-development)
10. [Code Quality &amp; Review](#10-code-quality--review)
11. [Advanced: Orchestration &amp; Automation](#11-advanced-orchestration--automation)
12. [Pro Tips &amp; Best Practices](#12-pro-tips--best-practices)

---

## 1. Understanding the Three Pillars

Claude Code has three layers of capability:

### **🛠️ Built-in Tools**

Core capabilities available out-of-the-box:

- `Read`, `Write`, `Edit` — file operations
- `Bash` — shell commands
- `Grep`, `Glob` — search
- `WebSearch`, `WebFetch` — internet access
- `Agent` — spawn subagents
- `Workflow` — multi-agent orchestration

### **⚡ Skills** (Slash Commands)

Pre-packaged prompt + tool bundles for specific tasks:

- `/run` — launch your app
- `/verify` — confirm changes work
- `/code-review` — review diffs
- `/simplify` — cleanup code
- `/batch` — parallel codebase changes
- `/deep-research` — multi-source research
- `/loop` — recurring tasks
- `/plan` — strategic planning
- Custom skills in `.claude/skills/`

### **🔌 MCP Servers**

External data sources and tools:

- Databases (MongoDB, Postgres, Supabase)
- APIs (GitHub, Slack, Sentry)
- Browsers (Playwright)
- Code tools (Serena, shadcn)
- Docs (Context7)

**The magic:** Combine all three for compound productivity.

---

## 2. Essential Setup (First 10 Minutes)

### Step 1: Install token-saving MCPs first

```bash
# Serena (symbol-level code navigation, 95% token reduction)
npx @oraios/serena init

# Context7 (version-pinned docs)
claude mcp add context7 -s user -- npx -y @upstash/context7-mcp@latest
```

### Step 2: Add your domain-specific MCPs

**Frontend:**

```bash
claude mcp add shadcn -s user -- npx -y shadcn-mcp
claude mcp add playwright -s user -- npx -y @playwright/mcp
```

**Backend/Database:**

```bash
claude mcp add mongodb -s user -- npx -y @mongodb-js/mcp-server
# OR
claude mcp add supabase -s user -- npx -y @supabase/mcp-server
```

**DevOps:**

```bash
claude mcp add github -s user -- npx -y @modelcontextprotocol/server-github
```

### Step 3: Configure environment variables

Edit `~/.claude/settings.json`:

```json
{
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_...",
    "MONGODB_URI": "mongodb://localhost:27017/mydb",
    "SUPABASE_ACCESS_TOKEN": "sbp_...",
    "SUPABASE_PROJECT_REF": "abc123"
  }
}
```

### Step 4: Set up project memory

```bash
cd your-project
claude
> /init                    # Generate CLAUDE.md
> /memory                  # Review and customize
```

Add project-specific rules to `CLAUDE.md`:

```markdown
# Project Guidelines

## Stack
- Next.js 14 (App Router)
- TypeScript
- Tailwind CSS + shadcn/ui
- MongoDB
- tRPC

## Code Style
- Use functional components
- Prefer server components
- 2-space indentation
- Named exports only

## Testing
Run `npm test` before committing.
```

### Step 5: Configure permissions

Start with `acceptEdits` mode for smooth iteration:

```json
{
  "permissions": {
    "defaultMode": "acceptEdits",
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Bash(git diff)"
    ]
  }
}
```

---

## 3. Token-Efficient Workflows

### ✅ Use Serena for large codebases

**Instead of:**

```
claude
> Read the entire auth service and find the login function
```

**Do this:**

```
claude
> Use Serena to locate the login symbol in the auth service
> [Serena returns just the function, not the whole 2000-line file]
```

### ✅ Delegate exploration to subagents

**Instead of:**

```
claude
> Read all files in src/ and explain the architecture
> [Dumps 50 files into context]
```

**Do this:**

```
claude
> /fork "Explore src/ and summarize the architecture"
> [Subagent explores, returns only the summary]
```

Or use the Explore agent:

```bash
claude --agent Explore "Find all database query patterns in the codebase"
```

### ✅ Use /compact regularly

When context fills up:

```
/compact Keep the recent auth refactoring discussion
```

### ✅ Use /plan for big changes

**Instead of:**

```
claude
> Refactor the entire payment flow
> [Starts editing immediately, 50 files later...]
```

**Do this:**

```
claude
> /plan Refactor the payment flow to use Stripe webhooks
> [Reviews plan]
> [Approves]
> [Implements methodically]
```

---

## 4. Frontend/UI Development

### Workflow: Build a new feature

**Step 1: Get the right docs**
Context7 auto-injects version-specific docs. Just mention the library:

```
claude
> Create a Next.js 14 server component that fetches user data
> [Context7 provides exact Next.js 14 App Router docs]
```

**Step 2: Add UI components**

```
claude
> Add a shadcn dialog component with a form inside
> [shadcn MCP installs the component]
```

Or use 21st.dev Magic for custom designs:

```
claude
> /ui Generate a pricing table with three tiers
> [Magic MCP generates the component]
```

**Step 3: Test in browser**

```
claude
> /run
> [App launches]
> Use Playwright to screenshot the new page
```

Or verify manually:

```
claude
> /verify "The pricing page shows three tiers"
> [Launches app, checks, reports back]
```

**Step 4: Review before committing**

```
claude
> /code-review high
> [Reviews diff for bugs and improvements]
```

### Built-in Skills for Frontend

- `/run` — launch dev server
- `/verify` — confirm UI works
- `/ui` — generate components (with Magic MCP)
- `/code-review` — catch bugs before commit
- `/simplify` — cleanup verbose code

---

## 5. Backend Development

### Workflow: API endpoint creation

**Step 1: Plan the endpoint**

```
claude
> /plan Create a POST /api/orders endpoint with validation
```

**Step 2: Implement with MCP assistance**
If using Supabase:

```
claude
> Implement the endpoint using Supabase MCP
> [Supabase MCP provides DB schema, executes test queries]
```

If using MongoDB:

```
claude
> Implement the endpoint. Use MongoDB MCP to check the orders collection schema
> [MongoDB MCP inspects schema]
```

**Step 3: Test**

```
claude
> Write a test for POST /api/orders and run it
> [Writes test, runs via Bash tool]
```

**Step 4: Document**

```
claude
> Add JSDoc comments and update the API docs
```

### Built-in Skills for Backend

- `/plan` — design APIs before coding
- `/code-review` — security & correctness
- `/security-review` — audit for vulnerabilities
- `/batch` — update multiple endpoints at once

---

## 6. Full-Stack MERN + Next.js

### Complete workflow example

**Setup (one-time):**

```bash
# Install MCPs
claude mcp add mongodb -s user -- npx -y @mongodb-js/mcp-server
claude mcp add context7 -s user -- npx -y @upstash/context7-mcp@latest
claude mcp add shadcn -s user -- npx -y shadcn-mcp
claude mcp add github -s user -- npx -y @modelcontextprotocol/server-github

# Set env vars in ~/.claude/settings.json
{
  "env": {
    "MONGODB_URI": "mongodb://localhost:27017/myapp",
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_..."
  }
}
```

**Day-to-day workflow:**

1. **Start a feature:**

```bash
claude --worktree feature-auth "Implement user authentication"
```

2. **Database schema:**

```
claude
> Use MongoDB MCP to show me the users collection schema
> Create a User model with email, password hash, and timestamps
```

3. **Backend API:**

```
claude
> Create POST /api/auth/register with Zod validation
> Use MongoDB MCP to insert the user
```

4. **Frontend form:**

```
claude
> Add a shadcn form component for registration
> Connect it to the /api/auth/register endpoint
```

5. **Test:**

```
claude
> /run
> Use Playwright to test the registration flow
```

6. **Review:**

```
claude
> /code-review high --fix
> [Finds issues, applies fixes]
```

7. **Commit & PR:**

```
claude
> Commit with message "feat: add user registration"
> Use GitHub MCP to create a PR
```

8. **Exit worktree:**

```bash
claude
> /exit
```

### Built-in Skills for Full-Stack

- `/run` — start dev server
- `/verify` — end-to-end testing
- `/code-review` — quality gate
- `/security-review` — auth/data checks
- `/batch` — update multiple files at once

---

## 7. Database Work

### Workflow: Schema design & migrations

**With MongoDB MCP:**

```
claude
> Use MongoDB MCP to list all collections
> Show me the products collection schema
> Add a new field "inStock" to all products
> [MongoDB MCP executes update]
```

**With Supabase MCP:**

```
claude
> Use Supabase MCP to list all tables
> Generate a migration to add a "status" column to orders
> Apply the migration
> Generate TypeScript types
> [Supabase MCP handles all steps]
```

**With Postgres MCP:**

```
claude
> Use Postgres MCP to inspect the schema
> Create an index on users.email
> [Postgres MCP executes DDL]
```

### Query optimization

```
claude
> /plan Optimize the slow dashboard query
> [Analyzes, suggests indexes]
> Use MongoDB MCP to create the indexes
```

---

## 8. DevOps & Infrastructure

### Workflow: CI/CD setup

**With GitHub MCP:**

```
claude
> Use GitHub MCP to create a .github/workflows/ci.yml
> Add steps: checkout, install, test, build
> Create a PR with this workflow
> [GitHub MCP creates the PR]
```

**Dockerfile creation:**

```
claude
> Create a production Dockerfile for this Next.js app
> Use Docker MCP to build and test it
```

**Kubernetes deployment:**

```
claude
> Use Kubernetes MCP to list deployments
> Create a k8s manifest for this app
> Apply it to the staging cluster
```

### Monitoring & debugging

```
claude
> Use Kubernetes MCP to get logs for the api-server pod
> [Analyzes logs]
> The error is in the DB connection. Use MongoDB MCP to verify the connection string
```

### Built-in Skills for DevOps

- `/run` — test locally before deploying
- `/security-review` — check for credential leaks
- `/batch` — update configs across multiple services

---

## 9. AI/ML Development

### Workflow: Model training & deployment

**Dataset preparation:**

```
claude
> Use Jupyter MCP to load the dataset
> Show me the first 10 rows
> Clean the data and create train/test splits
```

**Model selection:**

```
claude
> /deep-research "Best model for sentiment analysis on short text in 2026"
> [Multi-source research]
```

**Training:**

```
claude
> Use Jupyter MCP to run the training script
> Monitor the training loop
```

**Deployment:**

```
claude
> Create a FastAPI endpoint for the model
> Use Docker MCP to containerize it
> Use Kubernetes MCP to deploy to production
```

### Built-in Skills for AI/ML

- `/deep-research` — literature review
- `/run` — execute training scripts
- `/verify` — validate model outputs
- `/batch` — hyperparameter sweeps across experiments

---

## 10. Code Quality & Review

### Before committing

**Quick review:**

```
claude
> /code-review medium
```

**Thorough review:**

```
claude
> /code-review high --fix
> [Finds and fixes issues automatically]
```

**Security audit:**

```
claude
> /security-review
> [Checks for SQL injection, XSS, leaked secrets, etc.]
```

**Cleanup:**

```
claude
> /simplify
> [Removes duplication, improves clarity]
```

### Reviewing PRs

**GitHub PR review:**

```bash
claude
> /review 123
> [Reviews PR #123, posts inline comments]
```

**Or ultra-deep review:**

```bash
claude ultrareview 123
> [Cloud-based multi-agent review]
```

---

## 11. Advanced: Orchestration & Automation

### Parallel batch changes

```
claude
> /batch Add TypeScript types to all API route handlers
> [Spawns parallel agents, one per file]
```

### Recurring checks

```
claude
> /loop 5m /code-review medium
> [Reviews code every 5 minutes]
```

### Goal-driven work

```
claude
> /goal "All tests pass and coverage is above 80%"
> [Works autonomously until goal met]
```

### Scheduled tasks

```
claude
> /schedule "Every weekday at 9am, run /code-review and post results to Slack"
```

### Multi-agent workflows

For massive tasks:

```bash
claude
> Use Workflow to:
> 1. Research best practices for Next.js 15
> 2. Audit our codebase against those practices
> 3. Generate a migration plan
> 4. Apply fixes across all files
> 5. Run tests and verify
```

---

## 12. Pro Tips & Best Practices

### ⚡ Start every session with context

```
claude
> /resume my-feature
> [Continues where you left off]
```

Or name your sessions:

```bash
claude -n "auth-refactor"
```

### ⚡ Use worktrees for isolated work

```bash
claude --worktree feature-payments "Add Stripe integration"
# Work happens in isolated git worktree
# Exit with /exit when done
```

### ⚡ Let Claude run your tests

Instead of switching windows:

```
claude
> Run the tests
> [Runs via Bash tool, shows results]
```

### ⚡ Use background agents for slow tasks

```
claude
> /background "Deep research on Redis vs Memcached for this use case"
> [Research runs in background, you continue working]
```

### ⚡ Reduce permission prompts

```
claude
> /fewer-permission-prompts
> [Analyzes your usage, adds allowlist to settings.json]
```

### ⚡ Use plan mode for unfamiliar changes

```bash
claude --permission-mode plan
> Refactor the auth system to use OAuth
> [Proposes plan without editing]
> [Review and approve]
```

### ⚡ Combine skills with MCPs

```
claude
> /plan Create a real-time chat feature
> [Plan approved]
> Use Supabase MCP for the database
> Use shadcn MCP for the UI
> /run to test it
> /verify "Two users can send messages back and forth"
> /code-review high
```

### ⚡ Use Context7 for new libraries

```
claude
> I'm using tRPC v11 for the first time. Help me set it up.
> [Context7 injects exact v11 docs]
```

### ⚡ Leverage Serena for large files

```
claude
> Use Serena to find all occurrences of the UserService class
> Replace the authenticate method body with the new OAuth flow
> [Surgical edit, no wasted tokens]
```

---

## Complete Daily Workflow Example

### Morning: Start a new feature

```bash
# 1. Create isolated environment
claude --worktree feature-notifications -n notifications

# 2. Plan
> /plan Add email and push notifications

# 3. Implement
> Use Supabase MCP to create a notifications table
> Use shadcn to add a notification bell icon
> Create the backend API using tRPC
> [Context7 provides tRPC docs]

# 4. Test
> /run
> Use Playwright to click the bell and verify notifications load

# 5. Review
> /code-review high --fix

# 6. Commit
> git add -A
> git commit -m "feat: add notification system"
> Use GitHub MCP to create a PR
```

### Afternoon: Debug production issue

```bash
claude -c

# 1. Investigate
> Use Kubernetes MCP to get logs for the api-server
> [Finds error in logs]

# 2. Reproduce locally
> /run
> [Triggers the error]

# 3. Fix
> The issue is in the MongoDB query. Use MongoDB MCP to test the corrected query
> [MongoDB MCP confirms it works]

# 4. Deploy
> git commit -m "fix: correct MongoDB aggregation pipeline"
> Use GitHub MCP to create a hotfix PR
> Use Kubernetes MCP to restart the deployment
```

### Evening: Clean up and plan tomorrow

```bash
claude -c

> /compact Keep only the notifications work
> /export notifications-session.md
> /memory
> [Add note: "Remember to add rate limiting to the notifications API"]
```

---

## Keyboard Shortcuts Cheat Sheet

| Shortcut      | Action                   |
| ------------- | ------------------------ |
| `Shift+Tab` | Cycle permission modes   |
| `Ctrl+O`    | Transcript viewer        |
| `Ctrl+G`    | Edit prompt in $EDITOR   |
| `Esc Esc`   | Rewind menu              |
| `!` prefix  | Run shell command inline |
| `@` prefix  | Mention file             |
| `#` prefix  | Add to memory            |
| `/` prefix  | Skills menu              |

---

## Common Mistakes to Avoid

### ❌ Reading entire files when you need one function

**Instead:** Use Serena's symbol navigation.

### ❌ Dumping huge exploration results into main context

**Instead:** Use `/fork` or the Explore agent.

### ❌ Manually running tests in another terminal

**Instead:** Let Claude run them via the Bash tool.

### ❌ Implementing first, planning later

**Instead:** Use `/plan` for non-trivial changes.

### ❌ Forgetting to review before committing

**Instead:** Make `/code-review` muscle memory.

### ❌ Not using MCPs for repetitive tasks

**Instead:** Let MongoDB MCP execute queries, GitHub MCP manage PRs, etc.

### ❌ Ignoring token efficiency

**Instead:** Install Serena first, use subagents, compact regularly.

---

## Summary: The Optimal Stack

**For token efficiency:**

- Serena MCP + subagents + /compact

**For frontend:**

- Context7 + shadcn + Playwright + /ui + /run + /verify

**For backend:**

- Supabase/MongoDB MCP + /plan + /code-review + /security-review

**For full-stack:**

- All of the above + GitHub MCP + /batch

**For DevOps:**

- GitHub + Docker + Kubernetes MCPs + /security-review

**For AI/ML:**

- Jupyter + Hugging Face MCPs + /deep-research

**For quality:**

- /code-review + /simplify + /security-review + /verify

---

_Master these workflows and you'll 10x your productivity with Claude Code. Start with the Essential Setup, add MCPs as needed, and gradually incorporate skills into your daily routine._