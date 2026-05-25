# Scaffold CLI 🧱

⚡️ Spin up a fresh Node.js project in seconds. `scaffold` creates the folder, runs npm init, switches to ESM, installs the deps you pick, and can generate a clean backend folder structure from a template.

## Requirements ✅

- Bash-based shell on Windows (Git Bash recommended).
- Node.js (includes npm) on PATH.

## Installation 🛠️

```bash
git clone https://github.com/Jerome-Mondol/scaffold
cd scaffold
./installer.sh
source ~/.bashrc
```

## Usage 🚀

```bash
scaffold my-app
```

You will be prompted for dependencies and dev dependencies (space-separated), then you can pick a template to generate the starter structure.

## Default Template (Quick View) 📁

Creates a clean backend layout like:

```
src/ (config, controllers, models, routes, middlewares, utils, index.js)
tests/
.env
.gitignore
README.md
```

## Docs 📚

- Custom templates guide: [docs/markdowns/custom-template.md](docs/markdowns/custom-template.md)

## Notes 💡

- If `scaffold` is not found, restart Git Bash or run `source ~/.bashrc` again.
- If you move the repo, rerun `installer.sh` so the alias points to the new path.
