# Scaffold CLI 🧱

Create a clean Node.js project in minutes. `scaffold` generates a folder, runs `npm init`, switches the package metadata to ESM defaults, installs the dependencies you choose, and builds a backend structure from a template.

## What It Does

- Runs environment checks for your OS before any work starts.
- Creates a new project directory and bootstraps `package.json`.
- Installs dependencies and dev dependencies interactively.
- Generates folders and files from a YAML template.

## Requirements

- Bash shell (Git Bash on Windows is recommended)
- Node.js and npm available on PATH

## Install

```bash
git clone https://github.com/Jerome-Mondol/scaffold
cd scaffold
./installer.sh
source ~/.bashrc
```

## Use

```bash
scaffold my-app
```

You'll be prompted for production and development dependencies (space-separated). After that, select a template to generate the starter structure.

## Templates

Templates live in [templates/](templates/). Each file is a YAML blueprint.

### Default Template (Quick View)

```
src/ (config, controllers, models, routes, middlewares, utils, index.js)
tests/
.env
.gitignore
README.md
```

### Custom Templates

Follow the rules in [docs/markdowns/custom-template.md](docs/markdowns/custom-template.md) to build your own structure and drop it into [templates/](templates/).

## Pre-flight Checks

`scaffold` runs a small OS-specific binary before it starts:

- Windows: `tools/checkers/pre-flight-windows.exe`
- Linux: `tools/checkers/pre-flight-linux`
- macOS Intel: `tools/checkers/pre-flight-mac-intel`
- macOS ARM: `tools/checkers/pre-flight-mac-arm`

If you need to rebuild these binaries:

```bash
./build.sh
```

## Troubleshooting

- If `scaffold` is not found, restart Git Bash or run `source ~/.bashrc` again.
- If you move the repo, rerun `installer.sh` so the alias points to the new path.
- If pre-flight checks fail, rebuild binaries with `./build.sh` and try again.
