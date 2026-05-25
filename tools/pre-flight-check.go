package main

import (
	"fmt"
	"os"
	"os/exec"
)

const (
	ColorReset  = "\033[0m"
	ColorRed    = "\033[31m"
	ColorGreen  = "\033[32m"
	ColorCyan   = "\033[36m"
)

func main() {
	fmt.Printf("%s🔍 Running Environment Pre-Flight Checks...%s\n", ColorCyan, ColorReset)

	failed := false

	_, err := exec.LookPath("node")
	if err != nil {
		fmt.Printf("%s❌ Error: Node.js was not found on your system PATH.%s\n", ColorRed, ColorReset)
		fmt.Println("👉 Please install Node.js from https://nodejs.org before running scaffold.")
		failed = true
	} else {
		fmt.Printf("|-- Node.js: %sOK%s\n", ColorGreen, ColorReset)
	}


	_, err = exec.LookPath("bash")
	if err != nil {
		fmt.Printf("%s❌ Error: Bash was not found on your system PATH.%s\n", ColorRed, ColorReset)
		fmt.Println("👉 If you are on Windows, please run this tool using 'Git Bash'.")
		failed = true
	} else {
		fmt.Printf("|-- Bash environment: %sOK%s\n", ColorGreen, ColorReset)
	}

	if failed {
		fmt.Printf("\n%s🚨 Pre-flight checks failed! Fix missing requirements above.%s\n", ColorRed, ColorReset)
		os.Exit(1) 
	}


	fmt.Printf("\n%s🚀 All requirements met! Environment is healthy.%s\n\n", ColorGreen, ColorReset)
	os.Exit(0) 

}