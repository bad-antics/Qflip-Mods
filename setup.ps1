param(
    [switch]$SkipVisualStudio = $false,
    [switch]$SkipQt = $false,
    [switch]$BuildOnly = $false,
    [switch]$LaunchOnly = $false
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "bad-antics Flipper Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

function Test-ProgramInstalled {
    param([string]$Name, [string]$ExecutableName)
    
    try {
        $cmd = Get-Command $ExecutableName -ErrorAction SilentlyContinue
        if ($cmd) {
            Write-Host "[OK] $Name found" -ForegroundColor Green
            return $true
        }
    } catch {
        # Ignore
    }
    
    Write-Host "[MISSING] $Name not found" -ForegroundColor Red
    return $false
}

function Download-File {
    param([string]$Url, [string]$Path, [string]$Name)
    
    try {
        if (Test-Path $Path) {
            Write-Host "[CACHED] $Name already downloaded" -ForegroundColor Yellow
            return $true
        }
        
        Write-Host "[DOWNLOAD] Downloading $Name..." -ForegroundColor Cyan
        $ProgressPreference = "Continue"
        Invoke-WebRequest -Uri $Url -OutFile $Path -UseBasicParsing
        $ProgressPreference = "SilentlyContinue"
        
        Write-Host "[OK] Downloaded to: $Path" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "[ERROR] Failed to download $Name : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

if ($LaunchOnly) {
    Write-Host "Launching bad-antics Flipper..." -ForegroundColor Cyan
    $exePath = ".\build\Release\bad-antics Flipper.exe"
    
    if (Test-Path $exePath) {
        & $exePath
    } else {
        Write-Host "[ERROR] Executable not found: $exePath" -ForegroundColor Red
        Write-Host "Run setup without -LaunchOnly flag to build first." -ForegroundColor Yellow
    }
    exit
}

Write-Host "[CHECK] Checking current installations..." -ForegroundColor Cyan
Write-Host ""

$hasVisualStudio = $false
$hasQt = $false

if (-not $BuildOnly) {
    Write-Host "Visual Studio:" -ForegroundColor Yellow
    if (Test-ProgramInstalled "Visual Studio" "cl.exe") {
        $hasVisualStudio = $true
    }
    Write-Host ""
}

Write-Host "Qt Framework:" -ForegroundColor Yellow
if (Test-Path "C:\Qt\6.6.0\msvc2019_64\bin\qmake.exe" -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Qt 6.6.0 (MSVC 2019 64-bit) found at C:\Qt\6.6.0" -ForegroundColor Green
    $hasQt = $true
} elseif (Test-Path "C:\Qt" -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Qt found at C:\Qt" -ForegroundColor Green
    $hasQt = $true
} else {
    Write-Host "[MISSING] Qt not found" -ForegroundColor Red
}
Write-Host ""

$downloadsPath = Join-Path $env:TEMP "bad-antics-flipper-downloads"
if (-not (Test-Path $downloadsPath)) {
    New-Item -ItemType Directory -Path $downloadsPath | Out-Null
}

Write-Host "[DOWNLOAD] Preparing installers..." -ForegroundColor Cyan
Write-Host ""

if (-not $SkipVisualStudio -and -not $hasVisualStudio -and -not $BuildOnly) {
    $vsUrl = "https://c2rsetup.blob.core.windows.net/download/VS_Community.exe"
    $vsPath = Join-Path $downloadsPath "VisualStudio_Community_2022.exe"
    
    if (Download-File $vsUrl $vsPath "Visual Studio 2022 Community") {
        Write-Host ""
        Write-Host "[INFO] Visual Studio Installation Instructions:" -ForegroundColor Yellow
        Write-Host "1. The Visual Studio installer will open" -ForegroundColor White
        Write-Host "2. Select 'Desktop development with C++'" -ForegroundColor White
        Write-Host "3. Click 'Install'" -ForegroundColor White
        Write-Host "4. Wait for installation to complete" -ForegroundColor White
        Write-Host ""
        Write-Host "[WAITING] Press any key to launch Visual Studio installer..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        Write-Host "[LAUNCH] Launching Visual Studio installer..." -ForegroundColor Yellow
        Start-Process $vsPath -Wait
        Write-Host "[OK] Visual Studio installation complete" -ForegroundColor Green
        Write-Host ""
    }
}

if (-not $SkipQt -and -not $hasQt) {
    $qtUrl = "https://download.qt.io/official_releases/online_installers/qt-unified-windows-x64-online.exe"
    $qtPath = Join-Path $downloadsPath "Qt_Unified_Installer.exe"
    
    if (Download-File $qtUrl $qtPath "Qt Online Installer") {
        Write-Host ""
        Write-Host "[INFO] Qt Installation Instructions:" -ForegroundColor Yellow
        Write-Host "1. The Qt installer will open" -ForegroundColor White
        Write-Host "2. Sign in with Qt account (or skip)" -ForegroundColor White
        Write-Host "3. Select 'Custom installation'" -ForegroundColor White
        Write-Host "4. Choose Qt 6.6.x or later" -ForegroundColor White
        Write-Host "5. Select 'MSVC 2019 64-bit'" -ForegroundColor White
        Write-Host "6. Select additional libraries:" -ForegroundColor White
        Write-Host "   - Qt Serialport" -ForegroundColor White
        Write-Host "   - Qt SVG" -ForegroundColor White
        Write-Host "   - CMake" -ForegroundColor White
        Write-Host "7. Install to: C:\Qt" -ForegroundColor White
        Write-Host "8. Click 'Install'" -ForegroundColor White
        Write-Host "9. Wait for installation to complete" -ForegroundColor White
        Write-Host ""
        Write-Host "[WAITING] Press any key to launch Qt installer..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        Write-Host "[LAUNCH] Launching Qt installer..." -ForegroundColor Yellow
        Start-Process $qtPath -Wait
        Write-Host "[OK] Qt installation complete" -ForegroundColor Green
        Write-Host ""
    }
}

Write-Host "[CHECK] Verifying installations..." -ForegroundColor Cyan
Write-Host ""

$canBuild = $false

if (Test-Path "C:\Qt\6.6.0\msvc2019_64\bin\qmake.exe" -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Qt qmake found" -ForegroundColor Green
    $canBuild = $true
} else {
    Write-Host "[WARNING] Qt qmake not found at expected location" -ForegroundColor Yellow
    Write-Host "         Expected: C:\Qt\6.6.0\msvc2019_64\bin\qmake.exe" -ForegroundColor DarkGray
}

if (Get-Command cl.exe -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Visual Studio C++ compiler found" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Visual Studio C++ compiler not in PATH" -ForegroundColor Yellow
    Write-Host "         You may need to run from Visual Studio Developer Command Prompt" -ForegroundColor DarkGray
}

Write-Host ""

if ($canBuild) {
    Write-Host "[SUCCESS] All dependencies ready!" -ForegroundColor Green
    Write-Host ""
    Write-Host "[BUILD] Building bad-antics Flipper..." -ForegroundColor Cyan
    Write-Host ""
    
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
    Set-Location $scriptPath
    
    Write-Host "[EXEC] Running: build_windows.bat" -ForegroundColor Yellow
    cmd /c "build_windows.bat"
    
    Write-Host ""
    Write-Host "[SUCCESS] Build complete!" -ForegroundColor Green
    Write-Host ""
    
    if (Test-Path ".\build\Release\bad-antics Flipper.exe" -ErrorAction SilentlyContinue) {
        Write-Host "[LAUNCH] Launching bad-antics Flipper..." -ForegroundColor Cyan
        & ".\build\Release\bad-antics Flipper.exe"
    } else {
        Write-Host "[WARNING] Executable not found: .\build\Release\bad-antics Flipper.exe" -ForegroundColor Yellow
        Write-Host "          Build may have failed. Check output above." -ForegroundColor Yellow
    }
} else {
    Write-Host "[WARNING] Cannot build yet - missing dependencies" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[ACTION] Please complete installation of:" -ForegroundColor Yellow
    Write-Host "1. Visual Studio 2019+ with C++ development tools" -ForegroundColor White
    Write-Host "2. Qt 6.6 LTS with MSVC 2019 64-bit components" -ForegroundColor White
    Write-Host ""
    Write-Host "[INFO] Then run this script again." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[OK] Setup script completed" -ForegroundColor Green
Write-Host ""
