# 🚀 QUICK START CARD - bad-antics Flipper

## RUN THIS NOW (One Command)

```powershell
cd "C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper"; powershell -ExecutionPolicy Bypass -File setup.ps1
```

**That's it!** The script will handle:
- ✓ Checking for Visual Studio and Qt
- ✓ Downloading installers if needed
- ✓ Installing dependencies
- ✓ Building the application
- ✓ Launching bad-antics Flipper

---

## IF SOMETHING GOES WRONG

1. **Script won't run?**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
   ```

2. **Build fails?**
   - Delete `build` folder
   - Run setup.ps1 again
   - Check `build/CMakeFiles/cmake.log`

3. **Need help?**
   - Read `SETUP_GUIDE.md` → Troubleshooting section
   - Check `BUILD_WINDOWS_GUIDE.md` for build details

---

## MORE OPTIONS

```powershell
# Build only (if dependencies already installed)
powershell -ExecutionPolicy Bypass -File setup.ps1 -BuildOnly

# Launch only (if already built)
powershell -ExecutionPolicy Bypass -File setup.ps1 -LaunchOnly

# Manual build
.\build_windows.bat

# Manual launch
.\build\Release\bad-antics Flipper.exe
```

---

## DOCUMENTATION

| Need | File |
|------|------|
| Quick overview | `GETTING_STARTED.md` |
| Setup help | `SETUP_GUIDE.md` |
| Technical details | `IMPLEMENTATION_SUMMARY.md` |
| Build system | `BUILD_WINDOWS_GUIDE.md` |
| Command reference | `QUICKSTART.md` |
| Navigation | `DOCUMENTATION_INDEX.md` |

---

## PROJECT INFO

- **Location:** `C:\Users\pc123\OneDrive\Documents\pineflip\bad-antics-flipper\`
- **GitHub:** https://github.com/bad-antics/pineflip
- **Expected Output:** `.\build\Release\bad-antics Flipper.exe`

---

**Ready? Run the setup.ps1 command above!**
