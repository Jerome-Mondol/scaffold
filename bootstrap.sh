#!/bin/bash

# Stop immediately if any step crashes
set -e

# Grab the project name passed by the user
PROJECT_NAME=$1

# Validation: Block execution if they forgot to type a project name
if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Error: Please provide a project name!"
    echo "Usage: scaffold <project-name>"
    exit 1
fi

echo "========================================="
echo "🎉 SUCCESS: The 'scaffold' global command works!"
echo "========================================="
echo "🚀 Target Project Name: $PROJECT_NAME"
echo "📂 Executing from directory: $(pwd)"
echo "⚙️  Installer mapped this script path perfectly."
echo "========================================="