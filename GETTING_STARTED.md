# Next Steps to Build & Run bad-antics Flipper

## Current Status

✓ **Code:** Cloned, customized, and pushed to GitHub  
✓ **Features:** Avatar and profile customization implemented  
✓ **Scripts:** Setup and build scripts ready  
✗ **Dependencies:** Visual Studio and Qt 6.6 LTS not installed yet  
✗ **Build:** Awaiting dependency installation  
✗ **Execution:** Awaiting successful build  

## What You Need to Do

### Option A: Fully Automated (Recommended)

Run the setup script - it will handle everything:

```powershell
cd "C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper"
powershell -ExecutionPolicy Bypass -File setup.ps1
```

This will:
1. Detect if Visual Studio is installed
2. Detect if Qt 6.6 is installed
3. Download installers if missing
4. Guide you through installation
5. Build the application
6. Launch bad-antics Flipper

**Estimated time:** 1-2 hours (mostly installation)

### Option B: Manual Installation

If you prefer to install manually:

1. **Install Visual Studio 2022 Community**
   - https://visualstudio.microsoft.com/
   - Select: Desktop development with C++
   - Time: ~30 minutes

2. **Install Qt 6.6 LTS**
   - https://www.qt.io/download-open-source
   - Install to: C:\Qt
   - Select: MSVC 2019 64-bit
   - Time: ~30 minutes

3. **Build the project**
   ```cmd
   cd "C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper"
   build_windows.bat
   ```
   - Time: ~10 minutes

4. **Run the application**
   ```cmd
   .\build\Release\bad-antics Flipper.exe
   ```

## File Locations

| Item | Location |
|------|----------|
| Project Root | `C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper\` |
| Setup Script | `setup.ps1` |
| Build Script | `build_windows.bat` |
| Setup Guide | `SETUP_GUIDE.md` |
| Source Code | `src\`, `application\` |
| Avatar Feature | `application\profilesettings.h`, `profilesettings.cpp` |
| Profile UI | `application\qml\ProfileSettings.qml` |
| Expected Output | `.\build\Release\bad-antics Flipper.exe` |
| GitHub Repo | https://github.com/bad-antics/pineflip |

## Available Commands

```powershell
# Full setup (recommended)
powershell -ExecutionPolicy Bypass -File setup.ps1

# Skip Visual Studio (if already installed)
powershell -ExecutionPolicy Bypass -File setup.ps1 -SkipVisualStudio

# Skip Qt (if already installed)
powershell -ExecutionPolicy Bypass -File setup.ps1 -SkipQt

# Skip both (if both already installed)
powershell -ExecutionPolicy Bypass -File setup.ps1 -SkipVisualStudio -SkipQt

# Build only (assumes dependencies installed)
powershell -ExecutionPolicy Bypass -File setup.ps1 -BuildOnly

# Launch only (assumes build already exists)
powershell -ExecutionPolicy Bypass -File setup.ps1 -LaunchOnly

# Or manually build
build_windows.bat

# Or manually launch
.\build\Release\bad-antics Flipper.exe
```

## Features Implemented

### Avatar Customization
- Circle avatar display
- Image upload support
- PNG/JPG format support
- Persistent storage

### Profile Settings
- Edit user name
- Edit user description
- Save/reset functionality
- Qt QSettings persistence
- Cross-platform support

## Documentation

- **SETUP_GUIDE.md** - Detailed setup and troubleshooting
- **BUILD_WINDOWS_GUIDE.md** - Comprehensive build guide
- **IMPLEMENTATION_SUMMARY.md** - Technical architecture
- **README_BADANTICS.md** - Feature overview
- **QUICKSTART.md** - Quick reference

## Troubleshooting

### Script Won't Run
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
powershell -File setup.ps1
```

### Build Fails
1. Delete `build` folder
2. Ensure Visual Studio and Qt are properly installed
3. Run `build_windows.bat` again
4. Check `build\CMakeFiles\cmake.log` for errors

### Application Won't Launch
1. Verify build succeeded (check for `.exe` file)
2. Try running from Visual Studio Developer Command Prompt
3. Check `build\Release\bad-antics Flipper.exe` exists

## Getting Help

For detailed instructions, see:
- `SETUP_GUIDE.md` - Setup and troubleshooting
- `BUILD_WINDOWS_GUIDE.md` - Build process details
- `IMPLEMENTATION_SUMMARY.md` - Technical details

## Ready to Start?

**Run this command:**
```powershell
cd "C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper"; powershell -ExecutionPolicy Bypass -File setup.ps1
```

The script will handle the rest!
