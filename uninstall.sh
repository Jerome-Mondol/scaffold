#!/bin/bash

echo "🗑️  Starting uninstallation of scaffold CLI..."

# Define the profile files where the alias could be hidden
BASH_RC="$HOME/.bashrc"
BASH_PROFILE="$HOME/.bash_profile"

# 1. Clean up ~/.bashrc
if [ -f "$BASH_RC" ]; then
    echo "🧼 Removing scaffold configurations from ~/.bashrc..."
    # This deletes any lines containing 'scaffold' and saves the file
    sed -i '/scaffold/d' "$BASH_RC"
fi

# 2. Clean up ~/.bash_profile
if [ -f "$BASH_PROFILE" ]; then
    echo "🧼 Removing scaffold configurations from ~/.bash_profile..."
    sed -i '/scaffold/d' "$BASH_PROFILE"
fi

echo "--------------------------------------------------------"
echo "✅ Uninstallation complete!"
echo "➡️  Run 'source ~/.bashrc' or restart your terminal to apply changes."
echo "--------------------------------------------------------"