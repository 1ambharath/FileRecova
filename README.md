<p align="center">
<img alt="FileRecova Logo" src="assets/logo.png" width="280px">
</p>

<h1 align="center">FileRecova</h1>
<h3 align="center">Deep Forensic Disk Analysis & File Recovery GUI for Windows 11</h3>

<p align="center">
  <a href="https://github.com/1ambharath/FileRecova/actions/workflows/build.yml">
    <img src="https://github.com/1ambharath/FileRecova/actions/workflows/build.yml/badge.svg" alt="Build Status">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
  </a>
  <img src="https://img.shields.io/badge/platform-Windows%2011%20%7C%20Linux%20%7C%20macOS-lightgrey" alt="Platform">
</p>

---

## 📌 Attribution & Project Lineage

> [!NOTE]  
> **FileRecova** is forked from [**ostafen/digler**](https://github.com/ostafen/digler), an exceptional open-source forensic carving and disk recovery tool created by **Stefano Scafiti** ([@ostafen](https://github.com/ostafen)).
>
> All original core carving algorithms, DFXML reporting mechanics, and device scanner architecture are credited to Stefano Scafiti under the **MIT License**. We express immense gratitude to the author for laying the foundation of this project.

---

## 🚀 Enhancements in FileRecova

While the upstream `digler` project established a powerful CLI engine, desktop GUI builds for Windows were either unreleased or failed to compile due to path misconfigurations. **FileRecova** bridges this gap and brings a complete, polished Windows 11 desktop experience:

1. **Standalone Windows 11 GUI Executable (`FileRecovaGUI.exe`):**
   - Packaged as a single, self-contained `.exe` (~10.5 MB).
   - Powered by **Wails v2** and utilizes the built-in **Microsoft Edge WebView2** runtime (no bloated Electron dependencies required).
2. **Fixed Desktop Pipeline:**
   - Corrected entry point paths in `wails.json` and resolved Vite asset embedding issues.
   - Suppressed unwanted command prompt / console popups on launch using the Windows GUI subsystem flag (`-ldflags "-H windowsgui"`).
3. **Optimized Binary Size:**
   - Stripped debug symbols (`-s -w`), reducing the GUI binary size from ~15.5 MB down to ~10.5 MB.
4. **Native Windows Build Automation:**
   - Added `build-windows.ps1` for 1-click end-to-end building (node bundling + asset embedding + binary linking).
5. **Windows CI/CD Release Automation:**
   - Added Windows 11 GitHub Actions workflows to automatically build and attach GUI and CLI executables to GitHub Releases.
6. **Detailed Windows Forensic Guidance:**
   - Comprehensive instructions covering Windows User Account Control (UAC) and raw drive access (`\\.\PhysicalDriveX`).

---

## 🔍 Features

* **File-System Agnostic Recovery:** Recovers deleted or lost files directly from raw disk sectors even when filesystem metadata (NTFS, FAT32, exFAT, ext4) is wiped or corrupted.
* **Modern Windows 11 Desktop GUI:** Sleek dark-mode interface built with React 18, TypeScript, TailwindCSS, and Shadcn/UI.
* **Extensible Carving Plugins:** Modular file signature scanners supporting common formats (PNG, JPEG, PDF, MP3, ZIP, etc.).
* **DFXML Forensic Standards:** Generates machine-readable Digital Forensics XML (`.dfxml`) audit reports for compliance and auditing.
* **Dual Interface Options:** Choose between the visual desktop GUI for interactive recovery or the CLI for scripting and automation.
* **Virtual Filesystem Mount (Linux):** Mount forensic scan reports directly as a read-only FUSE filesystem without extracting data.

---

## 📦 Download Precompiled Binaries

Download the latest standalone executables directly from the [**Releases**](https://github.com/1ambharath/FileRecova/releases) page:

* **`FileRecovaGUI.exe`** — Native Windows 11 Desktop GUI application (no installation required).
* **`FileRecovaCLI.exe`** — Lightweight terminal tool for forensic analysis.

---

## 💻 How to Run on Windows 11

### 1. Recovering from Disk Image Files (`.dd`, `.img`, `.raw`, `.vhd`)
If you are analyzing a disk image file:
- Simply **double-click `FileRecovaGUI.exe`**.
- Drag or browse to your image file, choose the file signatures you want to carve, and start the scan.

### 2. Recovering from Physical Drives & Raw Partitions
Accessing raw storage sectors (`\\.\PhysicalDrive0`, `C:`, etc.) on Windows requires low-level disk permissions:
- **Right-click `FileRecovaGUI.exe`** → Select **"Run as Administrator"**.
- Select the physical drive from the detected disk devices list.

---

## 🛠️ CLI Usage

```bash
# 1. List supported file formats
FileRecovaCLI.exe formats

# 2. Scan a disk image and generate a DFXML forensic report
FileRecovaCLI.exe scan disk.img --dfxml report.xml

# 3. Scan a raw physical disk partition (Run terminal as Administrator)
FileRecovaCLI.exe scan C: --dump C:\recovered_files

# 4. Recover specific files from a pre-scanned DFXML report
FileRecovaCLI.exe recover disk.img --report report.xml --output recovered/
```

---

## 🏗️ Building from Source on Windows 11

### Prerequisites
* **Go 1.21+** ([Download Go](https://go.dev/dl/))
* **Node.js 18+** with `npm` ([Download Node.js](https://nodejs.org/))
* **WebView2 Runtime** (Preinstalled on Windows 11)

### 1-Click Build
Clone the repository and run the automated PowerShell build script:

```powershell
# Clone the repository
git clone https://github.com/1ambharath/FileRecova.git
cd FileRecova

# Run the Windows build pipeline
powershell -ExecutionPolicy Bypass -File .\build-windows.ps1
```

The compiled binaries will be output into the `bin/` directory:
- `bin\FileRecovaGUI.exe` (Desktop GUI)
- `bin\FileRecovaCLI.exe` (CLI Utility)

---

## ⚖️ License & Credits

* Original Project: [ostafen/digler](https://github.com/ostafen/digler) by **Stefano Scafiti**
* Enhancements & Windows GUI Pipeline: [FileRecova](https://github.com/1ambharath/FileRecova) by **Bharath**
* Licensed under the **[MIT License](LICENSE)**.
