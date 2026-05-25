#!/bin/bash

# Abort immediately if any command fails, an unset variable is referenced, or a pipe leaks errors
set -euo pipefail

# ==============================================================================
# CONFIGURATION & CONSTANTS
# ==============================================================================
PROJECT_NAME="${1:-}"
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
CHECKERS_DIR="$SCRIPT_DIR/tools/checkers"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

# Text Format Variables (ANSI Escape Codes)
RC="\033[0m"      # Reset Color
CYAN="\033[36m"    # System Actions
GREEN="\033[32m"   # Success States
YELLOW="\033[33m"  # Warnings

# ==============================================================================
# GUARD CLAUSES & INPUT VALIDATION
# ==============================================================================
if [ -z "$PROJECT_NAME" ]; then
    echo -e "⛔ [ERROR] Missing required project identity payload!"
    echo -e "👉 Usage: scaffold <project-name>\n"
    exit 1
fi

# ==============================================================================
# SYSTEM ENGINE FUNCTIONS
# ==============================================================================

run_preflight_checks() {
    echo -e "${CYAN}⚙️  [SYSTEM] Interrogating operating system environment...${RC}"

    case "$OSTYPE" in
        msys*|cygwin*|win32*)
            echo -e "ℹ️  [INFO] Native Windows environment detected."
            "$CHECKERS_DIR/pre-flight-windows.exe"
            ;;
        linux-gnu*)
            echo -e "ℹ️  [INFO] Unix Linux kernel detected."
            chmod +x "$CHECKERS_DIR/pre-flight-linux"
            "$CHECKERS_DIR/pre-flight-linux"
            ;;
        darwin*)
            echo -e "ℹ️  [INFO] Darwin macOS layer detected."
            local arch
            arch=$(uname -m)
            if [ "$arch" = "arm64" ]; then
                chmod +x "$CHECKERS_DIR/pre-flight-mac-arm"
                "$CHECKERS_DIR/pre-flight-mac-arm"
            else
                chmod +x "$CHECKERS_DIR/pre-flight-mac-intel"
                "$CHECKERS_DIR/pre-flight-mac-intel"
            fi
            ;;
        *)
            echo -e "${YELLOW}⚠️  [WARN] Unrecognized OS signature ($OSTYPE). Defaulting to Linux binary compilation...${RC}"
            chmod +x "$CHECKERS_DIR/pre-flight-linux"
            "$CHECKERS_DIR/pre-flight-linux"
            ;;
    esac

    echo -e "${GREEN}🚀 [LAUNCH] Pre-flight parameters clear! System environment verified.${RC}"
    echo "--------------------------------------------------------"
}




initialize_project_workspace() {
    

    echo -e "${GREEN}🚀 [LAUNCH] Initializing workspace scaffolding target: $PROJECT_NAME${RC}"
    mkdir -p "$PROJECT_NAME"
    cd "$PROJECT_NAME"


    echo -e "ℹ️  [INFO] Generating clean 'package.json' manifest..."
    npm init -y > /dev/null

    echo -e "${CYAN}⚙️  [SYSTEM] Invoking Node.js injector to pivot manifest metadata...${RC}"
    local new_project_path
    new_project_path="$(pwd)"
    node "$SCRIPTS_DIR/modify-package.mjs" "$new_project_path"
}



deploy_dependencies() {
    # Local arrays explicitly declared inside function scope
    local dependencies=()
    local dev_dependencies=()

    echo "--------------------------------------------------------"
    echo -e "${CYAN}⚙️  [SYSTEM] Launching Interactive Dependency Injection Engine${RC}"
    echo "--------------------------------------------------------"
    
    read -p "➜ Enter production dependencies (space-separated, or press Enter to skip): " -r -a dependencies
    read -p "➜ Enter development dependencies (space-separated, or press Enter to skip): " -r -a dev_dependencies
    echo ""

    # Install Production Modules
    if [ ${#dependencies[@]} -eq 0 ]; then
        echo -e "ℹ️  [INFO] No production modules specified. Skipping deployment phase..."
    else
        echo -e "ℹ️  [INFO] Fetching and unpacking production payload: ${dependencies[*]}..."
        npm install "${dependencies[@]}" --no-audit --no-fund > /dev/null
        echo -e "${GREEN}🚀 [LAUNCH] Production packages successfully integrated!${RC}"
    fi

    # Install Dev Modules
    if [ ${#dev_dependencies[@]} -eq 0 ]; then
        echo -e "ℹ️  [INFO] No development modules specified. Skipping deployment phase..."
    else
        echo -e "ℹ️  [INFO] Fetching and unpacking development payload: ${dev_dependencies[*]}..."
        npm install --save-dev "${dev_dependencies[@]}" --no-audit --no-fund > /dev/null
        echo -e "${GREEN}🚀 [LAUNCH] Development tools successfully integrated!${RC}"
    fi

    echo "--------------------------------------------------------"
    echo -e "${GREEN}🚀 [LAUNCH] Dependency assembly phase terminated successfully.${RC}"
    echo "--------------------------------------------------------"
}

execute_template_architect() {
    echo -e "${CYAN}⚙️  [SYSTEM] Handing thread execution context over to Template Blueprint Engine...${RC}"
    
    # Standardize directory path patterns to match semantic platform assumptions
    local node_project_path
    local node_tools_path
    node_project_path=$(cygpath -w "$(pwd)")
    node_tools_path=$(cygpath -w "$SCRIPT_DIR")

    node "$SCRIPTS_DIR/manage-template/template-builder.mjs" "$node_project_path" "$node_tools_path"
}

# ==============================================================================
# MAIN EXECUTION SEQUENCE
# ==============================================================================
main() {
    run_preflight_checks
    initialize_project_workspace
    deploy_dependencies
    execute_template_architect
}

main "$@"