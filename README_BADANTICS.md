# bad-antics Flipper Controller

A customized version of [QFlipper](https://github.com/flipperdevices/qFlipper) with avatar and profile customization features.

## New Features

### 1. **Customizable Avatar**
- Upload and display custom avatar images
- Supported formats: PNG, JPG, JPEG, BMP
- Avatar persists across sessions using QSettings
- Click on avatar to change it

### 2. **Customizable Profile**
- Set custom profile name (default: "Bad-Antics User")
- Set custom description/bio
- Profile data saved in `AppData/Roaming/bad-antics-flipper.conf`
- Profile displayed in the main window header

### 3. **Rebranded Interface**
- Application name changed from "qFlipper" to "bad-antics Flipper"
- Custom styling and theming for bad-antics branding
- Profile settings accessible from the main UI

## Architecture

### New Components

#### QML Components
- **ProfileSettings.qml** - Complete profile customization UI
  - Avatar selection and preview
  - Profile name and description inputs
  - Settings persistence buttons

#### C++ Backend
- **profilesettings.h/cpp** - Profile data management
  - Uses Qt's QSettings for persistent storage
  - Provides APIs for loading and saving profile data
  - Profile stored in native application data directory

### Storage
- Profile data stored in: `%APPDATA%/bad-antics-flipper/bad-antics-flipper.conf`
- Avatar images can be stored anywhere on disk
- Avatar path is stored relative or absolute in the config file

## Building

### Requirements
- Qt 5.15+ or Qt 6.3+
- Visual Studio 2019 or newer (Windows)
- CMake 3.16+

### Windows Build
```cmd
cd bad-antics-flipper
build_windows.bat
```

### Linux Build
```bash
./build_linux.sh
```

### macOS Build
```bash
./build_mac.sh
```

## Files Modified

- `qflipper_common.pri` - Updated NAME variable to "bad-antics Flipper"
- `application/application.pro` - Added profilesettings.cpp and profilesettings.h

## Files Added

- `application/profilesettings.h` - Profile settings header
- `application/profilesettings.cpp` - Profile settings implementation
- `application/components/ProfileSettings.qml` - Profile UI component
- `README_BADANTICS.md` - This file

## Integration Points

The ProfileSettings component integrates with the existing qFlipper UI:
1. Can be added as a new tab in the HomeOverlay
2. Profile data accessible via `Backend.profileSettings`
3. Avatar can be displayed in the main window header

## Future Enhancements

- [ ] Theme customization (colors, fonts)
- [ ] Custom window decorations
- [ ] User statistics/stats display
- [ ] Custom shortcuts/keybindings per profile
- [ ] Export/import profiles
- [ ] Avatar preset library

## License

This project is based on qFlipper, which is licensed under the GPL. See the main LICENSE file for details.

## Credits

- Original qFlipper: [flipperdevices](https://github.com/flipperdevices/qFlipper)
- Customizations: bad-antics team
