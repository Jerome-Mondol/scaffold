#!/bin/bash

# Stop immediately if any step crashes
set -e

# Grab the project name passed by the user
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Error: Please provide a project name!"
    echo "Usage: scaffold <project-name>"
    exit 1
fi

echo "🚀 Initializing project scaffolding for: $PROJECT_NAME"

# Initialize project
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize npm
echo "📦 Initializing npm..."
npm init -y > /dev/null


# Take input from user for what dependecies to install
echo "⚡ Enter the dependencies you want to install (separated by spaces):"
echo "👉 Example: express dotenv mongoose cors"
read -r -a DEPENDENCIES

if [ ${#DEPENDENCIES[@]} -eq 0 ]; then
    echo "ℹ️ No dependencies specified. Skipping..."

else 
    echo "📦 Installing: ${DEPENDENCIES[*]}..."
    npm i "${DEPENDENCIES[@]}" > /dev/null

    echo "Successfully installed ${DEPENDENCIES[*]}"
fi

echo "Project setup successully done!"
