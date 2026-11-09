# Browser Harness Setup

Connect an AI coding agent to local Chrome using Browser Harness. Works with agents that can run shell commands, including Codex, Claude Code, Antigravity (agy), and custom agent tools.

## Requirements

- macOS or Linux with Bash (Windows users can adapt the commands to their shell).
- Chrome with remote debugging available.
- [uv](https://docs.astral.sh/uv/getting-started/installation/).
- An agent that can run local shell commands. Skill discovery depends on the agent; a custom skill path or manual instructions work when automatic discovery is unavailable.

## Install

Download or clone this repository and open a terminal in its folder. Choose one:

```bash
# Install the CLI and save instructions locally (agent-independent default)
bash scripts/setup.sh

# Register a skill for Codex
bash scripts/setup.sh --target codex

# Register a skill for Claude Code
bash scripts/setup.sh --target claude

# Use any agent's supported skill directory, including agy
bash scripts/setup.sh --skill-dir /absolute/path/to/your/skills/browser-harness
```

The default saves instructions to `./.browser-harness/SKILL.md`. For Antigravity or another agent, point it to this file, copy its contents into the agent's instructions, or use `--skill-dir` with that agent's configured skill location. No particular Antigravity skill directory is assumed.

The installer updates Browser Harness using Python 3.12 through uv. It backs up an existing skill before replacing it. It does not connect to Chrome during installation. Run it from the directory where you want the default instructions saved.

## Connect Chrome

1. Open Chrome and visit `chrome://inspect/#remote-debugging`.
2. Enable **Allow remote debugging for this browser instance**.
3. Run `bash scripts/check.sh`.
4. Approve Chrome's connection prompt if shown.

A successful check prints information about the current page. This verifies the CLI connection; the agent must also be allowed to execute shell commands.

## Give your agent these instructions

Replace the skill path with the location printed by the installer:

```text
Read the Browser Harness instructions at .browser-harness/SKILL.md.
Use the browser-harness command for browser interaction.
Begin by checking the current page:

browser-harness <<'PYTHON'
print(page_info())
PYTHON
```

Local Chrome control needs no API key. The browser connection can access signed-in tabs, so use instructions you trust. Recording is optional and may capture page content; this installer does not enable it.

## Troubleshooting

```bash
browser-harness --doctor
```

Keep a waiting connection check running while approving Chrome's prompt. On macOS, if approval is blocked, run `browser-harness mac-approve` in a second terminal; it may require Accessibility access for the app running it. Return to the original check afterward. On other systems, approve the Chrome prompt manually.

If the command is missing after installation, open a new terminal to refresh PATH. If an agent does not discover a skill, reload the agent or give it the generated instructions directly. Remote servers without local Chrome require a separate remote browser setup.

## Maintenance

Run the same setup command again to update the CLI and skill instructions. The generated skill comes from the installed package, so it matches that version. This repository provides installation helpers; Browser Harness is installed separately from its package distribution.
