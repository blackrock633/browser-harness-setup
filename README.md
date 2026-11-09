# Browser Use setup for a friend

Set up local Chrome control for Codex on macOS using the current Browser Use browser harness. This repository contains setup helpers, not a copy of the upstream project.

## Quick start

You need Chrome, Codex, and [uv](https://docs.astral.sh/uv/getting-started/installation/). Install uv using its official instructions first. Then download this repository, open Terminal in its folder, and run:

```bash
bash scripts/setup.sh
```

Open Chrome and visit `chrome://inspect/#remote-debugging`. Enable **Allow remote debugging for this browser instance**. Then run:

```bash
bash scripts/check.sh
```

Approve Chrome’s connection prompt if one appears. A successful check prints information about the current page. You can now ask Codex to use the browser-harness skill to work in Chrome.

## What the installer does

- Installs or updates `browser-harness` with Python 3.12 through uv.
- Writes the upstream skill into your Codex skills folder. If that skill already exists, saves a dated backup first.
- Leaves Chrome permission changes to you and does not open a browser connection during installation.

Local Chrome control does not require a Browser Use API key. The helper does not enable recordings or copy cookies, profiles, credentials, or personal browser data into this repository. Browser control can access your signed-in tabs, so only run instructions you trust. Recording is optional; if you enable it later, screenshots and traces may contain page content.

## Troubleshooting

```bash
browser-harness --doctor
```

Keep a waiting connection check running while approving Chrome’s prompt. On macOS, if approval is blocked, run `browser-harness mac-approve` in a second Terminal window; it may ask for Accessibility access for the app running it. Then return to the original check.

If Terminal cannot find uv or browser-harness after installation, open a new Terminal window and retry. If Codex does not discover the new skill, restart Codex.

## About the name

Our earlier setup installed `browser-use` and registered a skill with that name. The upstream installation guide now uses `browser-harness`. This starter follows that current guide; it does not remove existing browser-use installations or skills. If Codex selects an older user-installed skill, inspect it and remove that stale skill manually when appropriate. Never remove bundled plugin caches.

## Sources

- [Official installation guide](https://github.com/browser-use/browser-harness/blob/main/install.md)
- [Browser harness source](https://github.com/browser-use/browser-harness)
- [Browser Use project](https://github.com/browser-use/browser-use)

Upstream commands may change. Consult the official guide if your installed version behaves differently.
