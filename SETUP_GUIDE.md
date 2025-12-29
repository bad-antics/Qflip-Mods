# bad-antics Flipper - Setup & Build Guide

## Quick Start

### Automated Setup (Recommended)

The easiest way to get started is using the automated setup script:

```powershell
cd "C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper"
powershell -ExecutionPolicy Bypass -File setup.ps1
```

This script will:
1. Check if Visual Studio and Qt are installed
2. Download Visual Studio 2022 Community (if needed)
3. Download Qt Online Installer (if needed)
4. Guide you through installation
5. Automatically build the application
6. Launch the compiled executable

### Manual Setup

If you prefer to install manually, follow these steps:

## Step 1: Install Visual Studio

1. Go to https://visualstudio.microsoft.com/
2. Download **Visual Studio 2022 Community** (or 2019+)
3. Run the installer
4. Select **Desktop development with C++** workload
5. Click **Install** and wait for completion
6. **Restart your computer** when prompted

**Note:** Make sure C++ development tools are installed, which includes:
- MSVC v143 C++ compiler (or newer)
- Windows 10/11 SDK
- CMake tools for Windows

## Step 2: Install Qt 6.6 LTS

1. Go to https://www.qt.io/download-open-source
2. Download **Qt Online Installer** for Windows
3. Run the installer
4. Sign in with Qt account (or skip)
5. Select **Custom installation**
6. Choose **Qt 6.6** (or later)
7. Select **MSVC 2019 64-bit** (or MSVC 2022)
8. Also select:
   - Qt Serialport
   - Qt SVG
   - CMake (if not already installed)
9. Set installation path to: `C:\Qt`
10. Click **Install** and wait for completion

## Step 3: Build the Application

Once dependencies are installed, build the project:

```cmd
cd C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper
build_windows.bat
```

The build process will:
1. Create a `build` directory
2. Configure the project with CMake
3. Compile with Qt and Visual Studio
4. Generate: `.\build\Release\bad-antics Flipper.exe`

**Build time:** 5-15 minutes depending on your system

## Step 4: Run the Application

After successful build:

```powershell
.\build\Release\bad-antics Flipper.exe
```

Or use the setup script with launch flag:

```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1 -LaunchOnly
```

## Script Options

The setup.ps1 script supports several flags:

```powershell
# Default: Check dependencies, download if needed, build, and launch
powershell -ExecutionPolicy Bypass -File setup.ps1

# Skip Visual Studio download/installation
powershell -ExecutionPolicy Bypass -File setup.ps1 -SkipVisualStudio

# Skip Qt download/installation
powershell -ExecutionPolicy Bypass -File setup.ps1 -SkipQt

# Skip both installers (build only if dependencies exist)
powershell -ExecutionPolicy Bypass -File setup.ps1 -SkipVisualStudio -SkipQt -BuildOnly

# Build-only mode (assumes dependencies installed)
powershell -ExecutionPolicy Bypass -File setup.ps1 -BuildOnly

# Launch existing build without rebuilding
powershell -ExecutionPolicy Bypass -File setup.ps1 -LaunchOnly
```

## Troubleshooting

### Issue: "Visual Studio C++ compiler not found"

**Solution:** 
- Make sure you have the **Desktop development with C++** workload installed
- You may need to run from **Visual Studio Developer Command Prompt**
- Or add Visual Studio to PATH:
  ```powershell
  # Run once in Developer Command Prompt to set environment
  setx PATH "%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\bin\Hostx64\x64"
  ```

### Issue: "Qt qmake not found"

**Solution:**
- Verify Qt is installed at `C:\Qt\6.6.0\msvc2019_64`
- If installed elsewhere, update the path in `setup.ps1` and `build_windows.bat`
- Check that you installed the **MSVC 2019 64-bit** component

### Issue: Build fails with CMake errors

**Solution:**
- Delete the `build` directory and try again:
  ```powershell
  Remove-Item .\build -Recurse -Force
  .\build_windows.bat
  ```
- Make sure you have admin privileges
- Check that Visual Studio and Qt are properly installed

### Issue: "Permission denied" when running setup.ps1

**Solution:**
```powershell
# Set execution policy for current user
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Then run the script
powershell -File setup.ps1
```

## Project Structure

```
bad-antics-flipper/
├── src/                      # Source code
│   ├── ui/                  # Qt UI components
│   ├── backend/             # Core application logic
│   └── ...
├── CMakeLists.txt           # CMake build configuration
├── qflipper_common.pri      # Qt project common settings
├── application/
│   ├── application.pro      # Qt project file
│   ├── qml/
│   │   └── ProfileSettings.qml  # Avatar/Profile UI
│   ├── profilesettings.h    # Profile backend header
│   └── profilesettings.cpp  # Profile backend implementation
├── build_windows.bat        # Windows build script
├── setup.ps1               # Automated setup script
├── SETUP_GUIDE.md         # This file
└── ...
```

## Build Output

After successful build:
- **Executable:** `.\build\Release\bad-antics Flipper.exe`
- **Build logs:** `.\build\CMakeFiles\cmake.log`
- **Objects:** `.\build\CMakeFiles\` and `.\build\*.obj`

## Next Steps

1. Launch the application: `.\build\Release\bad-antics Flipper.exe`
2. Test avatar/profile customization
3. Connect to Flipper Zero device (if available)
4. See [README_BADANTICS.md](README_BADANTICS.md) for feature documentation

## Additional Resources

- [Qt Documentation](https://doc.qt.io/)
- [QFlipper GitHub](https://github.com/flipperdevices/qFlipper)
- [Visual Studio Community](https://visualstudio.microsoft.com/community/)

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review build logs in `.\build\CMakeFiles\`
3. Ensure all dependencies are correctly installed
4. See [BUILD_WINDOWS_GUIDE.md](BUILD_WINDOWS_GUIDE.md) for detailed build documentation
