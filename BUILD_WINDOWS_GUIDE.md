# bad-antics Flipper Controller - Windows Build Guide

This guide explains how to build the bad-antics Flipper Controller on Windows.

## Prerequisites

### Required Software

1. **Visual Studio 2019 or newer**
   - Download from: https://visualstudio.microsoft.com/downloads/
   - Install with "Desktop development with C++" workload
   - Required components:
     - MSVC v142 or newer
     - Windows 10/11 SDK
     - CMake tools

2. **Qt 6.3+ (or Qt 5.15+)**
   - Download from: https://www.qt.io/download-open-source
   - Recommended: Qt 6.6 LTS
   - Installation path: `C:\Qt` (or customize in build script)
   - Select components:
     - Qt Creator IDE
     - MSVC 2019 64-bit (or your VS version)
     - CMake
     - Ninja
     - Additional libraries: Qt Serialport, Qt SVG

3. **Git**
   - Download from: https://git-scm.com/download/win
   - Required for cloning and building

4. **NSIS (Optional, for installer)**
   - Download from: https://nsis.sourceforge.io/Download
   - Only needed if you want to create the installer executable

## Directory Structure

```
C:\
├── Qt\
│   ├── 6.6.0\
│   │   ├── msvc2019_64\
│   │   └── Tools\
│   └── Tools\
│       └── CMake\
└── bad-antics-flipper\
    ├── application\
    ├── backend\
    ├── dfu\
    ├── plugins\
    └── build_windows.bat
```

## Build Steps

### 1. Clone the Repository

```powershell
cd C:\
git clone https://github.com/your-repo/bad-antics-flipper.git bad-antics-flipper
cd bad-antics-flipper
```

### 2. Edit Build Configuration

Edit `build_windows.bat` to match your environment:

```batch
@echo off
setlocal

REM Adjust these paths to match your installation
set QT_PATH=C:\Qt\6.6.0\msvc2019_64
set MSVC_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community
set CMAKE_PATH=C:\Qt\Tools\CMake\bin
set NINJA_PATH=C:\Qt\Tools\Ninja

REM Build configuration
set BUILD_TYPE=Release
set BUILD_DIR=build_win64

REM Continue with build...
```

### 3. Run the Build Script

```powershell
cd C:\bad-antics-flipper
.\build_windows.bat
```

The script will:
1. Create a build directory
2. Generate Visual Studio project files using CMake
3. Compile the project
4. Generate the installer (if NSIS is installed)

### 4. Output

After successful build:
- **Application**: `build_win64\Release\bad-antics Flipper.exe`
- **Installer** (if NSIS available): `build_win64\bad-antics-flipper-setup.exe`

## Alternative: Manual Build with Qt Creator

### Step 1: Open Project in Qt Creator
1. Launch Qt Creator
2. File → Open File or Project
3. Navigate to `bad-antics-flipper/qFlipper.pro`
4. Select your Qt 6.6 (msvc2019_64) kit

### Step 2: Configure Build
1. Left sidebar: "Projects" tab
2. Select "Release" build configuration
3. Edit CMakeLists.txt if needed
4. Build settings should auto-detect Qt and compiler

### Step 3: Build
1. Build → Build Project "qFlipper"
2. Wait for compilation to complete

### Step 4: Run
- Build → Run
- Or execute the .exe directly from the build folder

## Troubleshooting

### Build Fails - Qt Not Found
**Problem**: `CMake Error at cmake/Qt.cmake:XX (message): Qt not found`

**Solution**:
```batch
REM Edit build_windows.bat to correct Qt path:
set QT_PATH=C:\Qt\6.6.0\msvc2019_64
REM Or use Qt installed elsewhere:
set QT_PATH=C:\Your\Qt\Installation\Path\6.6.0\msvc2019_64
```

### Build Fails - Visual Studio Not Found
**Problem**: `Could not find Visual Studio` or compiler errors

**Solution**:
1. Ensure Visual Studio is installed with C++ development tools
2. Update `MSVC_PATH` in build script
3. From Developer Command Prompt, try:
   ```bash
   cmake --version
   cl.exe
   ```

### MSVC Compiler Errors
**Problem**: `error MSB6006: "cl.exe" exited with code`

**Solution**:
1. Open Visual Studio Developer Command Prompt
2. Navigate to project directory
3. Run build script from there
4. Or ensure Visual Studio path is correct in build script

### CMake Cache Issues
**Problem**: Changes to CMakeLists.txt not reflected

**Solution**:
```powershell
Remove-Item -Recurse -Force .\build_win64
.\build_windows.bat
```

### Qt Module Not Found
**Problem**: `Could not find Qt module X`

**Solution**:
1. Verify Qt installation has all components
2. Check Qt Creator → Tools → Options → Qt Versions
3. Reinstall Qt with missing modules from Qt Maintenance Tool

## Building for Different Qt Versions

### For Qt 5.15:
```batch
set QT_PATH=C:\Qt\5.15.0\msvc2019_64
REM May need additional setup for older Qt versions
```

### For Qt 6 (Multiple versions):
```batch
REM For Qt 6.3:
set QT_PATH=C:\Qt\6.3.0\msvc2019_64

REM For Qt 6.6 LTS (recommended):
set QT_PATH=C:\Qt\6.6.0\msvc2019_64
```

## Distribution

### As Standalone .exe
1. Copy the built .exe to distribution folder
2. Run Qt's `windeployqt` tool to collect dependencies:
   ```powershell
   C:\Qt\6.6.0\msvc2019_64\bin\windeployqt.exe "bad-antics Flipper.exe"
   ```
3. Package with all DLL files

### As Installer
1. Ensure NSIS is installed
2. Build script automatically generates installer
3. Distribute `build_win64\bad-antics-flipper-setup.exe`

## Testing the Build

After building, test the application:

```powershell
cd build_win64\Release
".\bad-antics Flipper.exe"
```

Expected behavior:
1. Window opens with bad-antics branding
2. Auto-connects to Flipper device if available
3. Profile settings load from config file
4. Avatar displays correctly

## Next Steps

- [x] Build from source
- [ ] Test all features
- [ ] Create installer
- [ ] Sign executable (optional, for distribution)
- [ ] Create GitHub release

## Support

For issues:
1. Check [qFlipper GitHub](https://github.com/flipperdevices/qFlipper) for base project issues
2. Check build script error messages
3. Ensure all prerequisites are installed
4. Try clean rebuild: `Remove-Item -Recurse -Force .\build_win64`

## Additional Resources

- Qt Documentation: https://doc.qt.io/
- CMake: https://cmake.org/documentation/
- Visual Studio: https://docs.microsoft.com/en-us/visualstudio/
- qFlipper Source: https://github.com/flipperdevices/qFlipper
