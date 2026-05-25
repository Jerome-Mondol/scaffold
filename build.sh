#!/bin/bash
set -e

echo "📦 Starting Go Cross-Compilation Engine..."
cd tools

FILE_NAME="pre-flight-check.go"

# 1. Windows (64-bit architecture)
echo "🖥️  Compiling for Windows..."
GOOS=windows GOARCH=amd64 go build -o checkers/pre-flight-windows.exe "$FILE_NAME"

# 2. Linux (64-bit architecture)
echo "🐧 Compiling for Linux..."
GOOS=linux GOARCH=amd64 go build -o checkers/pre-flight-linux "$FILE_NAME"

# 3. macOS Intel Chips (Core i5/i7/i9)
echo "🍏 Compiling for macOS (Intel)..."
GOOS=darwin GOARCH=amd64 go build -o checkers/pre-flight-mac-intel "$FILE_NAME"

# 4. macOS Apple Silicon Chips (M1/M2/M3/M4)
echo "🍎 Compiling for macOS (Apple Silicon)..."
GOOS=darwin GOARCH=arm64 go build -o checkers/pre-flight-mac-arm "$FILE_NAME"

echo "✅ All binaries compiled successfully inside the /tools directory!"