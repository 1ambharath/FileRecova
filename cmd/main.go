// Copyright (c) 2025 Stefano Scafiti / Bharath (FileRecova)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
package main

import (
	"fmt"

	"github.com/ostafen/digler/cmd/cmd"
	"github.com/ostafen/digler/internal/env"
)

func main() {
	PrintLogo()

	_ = cmd.Execute()
}

func PrintLogo() {
	fmt.Println("  ______ _ _       _____                             ")
	fmt.Println(" |  ____(_) |     |  __ \\                            ")
	fmt.Println(" | |__   _| | ___ | |__) |___  ___ _____   ____ _    ")
	fmt.Println(" |  __| | | |/ _ \\|  _  // _ \\/ __/ _ \\ \\ / / _` |   ")
	fmt.Println(" | |    | | |  __/| | \\ \\  __/ (_| (_) \\ V / (_| |   ")
	fmt.Println(" |_|    |_|_|\\___||_|  \\_\\___|\\___\\___/ \\_/ \\__,_|   ")
	fmt.Println()
	fmt.Println("FileRecova: Deep Forensic Disk Analysis & File Recovery Tool")
	fmt.Println("Forked from open-source recovery engine by Stefano Scafiti (MIT License)")
	fmt.Println()
	fmt.Printf("Version:    %s\n", env.Version)
	fmt.Printf("Commit:     %s\n", env.CommitHash)
	fmt.Printf("Build Time: %s\n", env.BuildTime)
	fmt.Println(" ")
}
