# Blobby QML Plugin

Blobby is a custom QML plugin that provides high-performance, shader-based "blob" visuals for Qt6 applications. It allows for the creation of organic, fluid shapes using C++ and GLSL.

## Features

- **Shader-Based Rendering**: Uses custom GLSL shaders for smooth, organic visuals.
- **Flexible Components**:
    - `BlobGroup`: A container to manage multiple blob shapes.
    - `BlobShape`: The base class for blob elements.
    - `BlobRect` & `BlobInvertedRect`: Specialized rectangular blob shapes.
    - `BlobMaterial`: Controls the visual properties of the blobs.
- **Qt6 Integration**: Fully integrated as a QML module.

## Requirements

- **Qt 6** (Core, Qml, Gui, Quick, ShaderTools)
- **CMake** (3.16+)
- **C++23** compliant compiler
- **spirv-tools** (for shader compilation)

## Installation & Usage

### Using Nix (Recommended)

If you use Nix or NixOS, you can add this project as a flake input.

1. Add the input to your `flake.nix`:
   ```nix
   inputs.blobby.url = "github:Nihilicht/blobby.qml";
   ```

2. Add the package to your system or shell:
   ```nix
   environment.systemPackages = [ inputs.blobby.packages.${pkgs.system}.default ];
   ```

3. Set the QML import path using the exported path:
   ```nix
   environment.variables.QML2_IMPORT_PATH = inputs.blobby.qmlImportPath;
   ```

### Building from Source

```bash
mkdir build && cd build
cmake ..
make
```

The plugin will be deployed to `build/imports/Blobby`. To use it during development, point your `QML2_IMPORT_PATH` to the `build/imports` directory.

## QML Usage

Once the plugin is installed and the import path is set, you can use it in your QML files:

```qml
import QtQuick
import Blobby 1.0

Window {
    width: 640
    height: 480
    visible: true
    color: "#1a1a1a"

    BlobGroup {
        anchors.fill: parent
        
        BlobRect {
            x: 100; y: 100
            width: 200; height: 200
            // Blob properties here
        }
    }
}
```

## Project Structure

- `src/`: C++ source code and headers.
- `src/shaders/`: GLSL shader files (`.vert`, `.frag`).
- `src/qmldir`: QML module definition.
- `flake.nix`: Nix flake configuration for reproducible builds.
- `CMakeLists.txt`: Build configuration.

## Credits

This code was originally extracted from [caelestia-dots/shell](https://github.com/caelestia-dots/shell), with all constants parameterized for general use.

## Notes
- Reference commit for blob features: `ddcfd10661e02b53705c0264e982debac04e215e` (used for tracking future diffs).
