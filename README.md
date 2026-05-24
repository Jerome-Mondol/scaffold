# Scaffold CLI 🧱

⚡️ Spin up a fresh Node.js project in seconds. `scaffold` creates the folder, runs npm init, switches to ESM, and installs the deps you pick.

## Requirements ✅

- Bash-based shell on Windows (Git Bash recommended).
- Node.js (includes npm) on PATH.

## Installation 🛠️

```bash
git clone https://github.com/Jerome-Mondol/scaffold
cd scaffold
npm install
bash installer.sh
source ~/.bashrc
```

## Usage 🚀

```bash
scaffold my-app
```

You will be prompted for dependencies and dev dependencies (space-separated).

## Notes 💡

- If `scaffold` is not found, restart Git Bash or run `source ~/.bashrc` again.
- If you move the repo, rerun `installer.sh` so the alias points to the new path.
