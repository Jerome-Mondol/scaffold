#!/bin/bash

# Safety switch
set -e

echo "Beginning Global Installation of scaffold CLI..."

REPO_PATH=$(pwd)

SCRIPT_PATH="$REPO_PATH/bootstrap.sh"

chmod +x "$SCRIPT_PATH"

PROFILE_FILE="$HOME/.bashrc"

if [ ! -f "$PROFILE_FILE" ]; then
    echo "📄 Creating missing .bashrc file in your Windows User profile..."
    touch "$PROFILE_FILE"
fi

if grep -q "alias scaffold=" "$PROFILE_FILE" 2>/dev/null; then 
    echo "The scaffold command is already configured in your profile"
else 
    echo "" >> "$PROFILE_FILE"
    echo "# Scaffold CLI global command" >> "$PROFILE_FILE"
    echo "alias scaffold=\"bash '$SCRIPT_PATH'\"" >> "$PROFILE_FILE" 

    echo "🚀 Global alias successfully injected into $PROFILE_FILE!"
fi

BOOT_PROFILE="$HOME/.bash_profile"
if [ ! -f "$BOOT_PROFILE" ] || ! grep -q "source ~/.bashrc" "$BOOT_PROFILE" 2>/dev/null; then
    echo "source ~/.bashrc" >> "$BOOT_PROFILE"
fi

echo "--------------------------------------------------------"
echo "✅ Installation complete!"
echo "👉 IMPORTANT: Run 'source ~/.bashrc' or restart Git Bash to activate the command."
echo "--------------------------------------------------------"