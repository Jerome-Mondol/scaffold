#!/bin/bash

# Stop immediately if any step crashes
set -e

# Grab the project name passed by the user
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "⛔ Error: Please provide a project name!"
    echo "Usage: scaffold <project-name>"
    exit 1
fi

echo "✨ Initializing project scaffolding for: $PROJECT_NAME"

# Initialize project
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize npm
echo "📦 Initializing npm..."
npm init -y > /dev/null

# change the type in the package.json file
NEW_PROJECT_PATH="$(pwd)"
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"
node "$SCRIPTS_DIR/modify-package.mjs" "$NEW_PROJECT_PATH"


# Take input from user for what dependecies to install
echo "💡 Example: express dotenv mongoose cors"
read -p "➜ Enter the dependencies you want to install (space-separated): " -r -a DEPENDENCIES

read -p "➜ Enter the dev dependencies you want to install (space-separated): " -r -a DEV_DEPENDENCIES



# install the dependencies 
if [ ${#DEPENDENCIES[@]} -eq 0 ]; then
    echo "ℹ️  No regular dependencies specified. Skipping..."
else 
    echo "📦 Installing: ${DEPENDENCIES[*]}..."
    npm install "${DEPENDENCIES[@]}" > /dev/null
    echo "✅ Installed ${DEPENDENCIES[*]}"
fi

# install the dev dependencies 
if [ ${#DEV_DEPENDENCIES[@]} -eq 0 ]; then
    echo "ℹ️  No dev dependencies specified. Skipping..."
else
    echo "🧰 Installing dev dependencies: ${DEV_DEPENDENCIES[*]}..."
    npm install --save-dev "${DEV_DEPENDENCIES[@]}" > /dev/null
    echo "✅ Installed ${DEV_DEPENDENCIES[*]}"
fi

echo "--------------------------------------------------------"
echo "✅ Dependency setup phase complete!"
echo "--------------------------------------------------------"

NODE_PROJECT_PATH=$(cygpath -w "$(pwd)")
NODE_TOOLS_PATH=$(cygpath -w "$SCRIPT_DIR")

node "$SCRIPTS_DIR/manage-template/template-builder.mjs" "$NODE_PROJECT_PATH" "$NODE_TOOLS_PATH"