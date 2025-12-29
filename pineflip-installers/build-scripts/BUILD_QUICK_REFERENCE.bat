@echo off
REM Quick reference and summary for Bad-Antics Device Manager build system

echo.
echo ════════════════════════════════════════════════════════════════
echo     Bad-Antics Device Manager - Build System Quick Reference
echo ════════════════════════════════════════════════════════════════
echo.
echo 📦 BUILD OPTIONS:
echo ────────────────────────────────────────────────────────────────
echo.
echo   1. QUICK BUILD (Just the executable):
echo      python build_exe_advanced.py
echo.
echo   2. FULL INSTALLER (Executable + Windows installer):
echo      build_installer.bat
echo.
echo   3. ORIGINAL METHOD (Simple build):
echo      python build_exe.py
echo.
echo ────────────────────────────────────────────────────────────────
echo 📋 OUTPUT FILES:
echo ────────────────────────────────────────────────────────────────
echo.
echo   dist\Bad-Antics_Device_Manager.exe
echo     → Portable executable, no installation needed
echo     → Size: 150-200 MB
echo     → Run directly from anywhere
echo.
echo   dist\Bad-Antics_Device_Manager_Setup.exe
echo     → Professional Windows installer
echo     → Size: 60-80 MB (compressed)
echo     → Creates Start Menu shortcuts, desktop icons
echo     → Hacker-themed installer wizard
echo.
echo ────────────────────────────────────────────────────────────────
echo 🛠️ BUILD SCRIPTS:
echo ────────────────────────────────────────────────────────────────
echo.
echo   build_exe_advanced.py
echo     • Enhanced PyInstaller wrapper
echo     • Creates hacker-themed icon automatically
echo     • Cleans up build artifacts
echo     • Output: dist\Bad-Antics_Device_Manager.exe
echo.
echo   build_installer.bat
echo     • Complete automation script
echo     • One-click build and installer creation
echo     • Checks for dependencies
echo     • Requires: Inno Setup 6
echo     • Output: Both .exe and Setup.exe
echo.
echo ────────────────────────────────────────────────────────────────
echo ⚙️ PREREQUISITES:
echo ────────────────────────────────────────────────────────────────
echo.
echo   Python 3.10+
echo     → Download: https://www.python.org
echo     → Check "Add Python to PATH" during installation
echo.
echo   Inno Setup 6 (for installer only)
echo     → Download: https://jrsoftware.org/isdl.php
echo     → Install to default location
echo     → Not needed for portable .exe
echo.
echo ────────────────────────────────────────────────────────────────
echo 🎨 CUSTOMIZATION:
echo ────────────────────────────────────────────────────────────────
echo.
echo   Installer Configuration:
echo     → Edit: Bad-Antics_Device_Manager.iss
echo     → Change name, version, publisher, etc.
echo.
echo   Custom Installer Graphics:
echo     → Create: installer_banner.bmp (164×314 pixels)
echo     → Create: installer_icon.bmp (55×57 pixels)
echo     → Place in same folder as .iss file
echo.
echo   Icon Color Scheme (Hacker Theme):
echo     → Primary: #00ff00 (Matrix green)
echo     → Background: #0a0a0a (Deep black)
echo     → Accent: #00ff00 (Bright green)
echo.
echo ────────────────────────────────────────────────────────────────
echo 📚 DOCUMENTATION:
echo ────────────────────────────────────────────────────────────────
echo.
echo   INSTALLER_GUIDE.md
echo     • Complete installer documentation
echo     • Customization instructions
echo     • Troubleshooting guide
echo     • Release checklist
echo.
echo ────────────────────────────────────────────────────────────────
echo 🚀 EXAMPLE WORKFLOW:
echo ────────────────────────────────────────────────────────────────
echo.
echo   1. Install Python 3.10+
echo   2. Install Inno Setup 6
echo   3. Run: build_installer.bat
echo   4. Wait 5 minutes for build to complete
echo   5. Share: dist\Bad-Antics_Device_Manager_Setup.exe
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo For detailed information, see: INSTALLER_GUIDE.md
echo.
pause
