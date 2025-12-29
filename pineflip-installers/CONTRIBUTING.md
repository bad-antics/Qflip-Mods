# Contributing to Pineflip Installers

We welcome contributions to the Pineflip Installers project!

## Project Structure

- `build-scripts/` - Build automation scripts
- `documentation/` - Building and distribution guides
- Various installer configurations for different platforms

## Building Installers

```bash
# Windows installer (requires Inno Setup)
.\build_installer.bat

# Advanced build with custom options
python build_exe_advanced.py

# Simple executable build
python build_exe.py
```

## Requirements
- Python 3.8+
- PyInstaller for EXE generation
- Inno Setup for Windows installers
- Supporting libraries (see documentation)

## Code Guidelines
- Write clear, maintainable build scripts
- Document build procedures
- Test on target platforms
- Include error handling
- Maintain version consistency

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the build output
5. Commit with clear messages
6. Open a Pull Request

## Build Testing

Please test your changes on:
- Windows 10/11
- macOS (if applicable)
- Linux (if applicable)

## Documentation

Update `documentation/` when:
- Build process changes
- New platforms are supported
- Tools or dependencies are updated

Thank you for contributing!
