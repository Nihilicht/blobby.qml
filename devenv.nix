{ pkgs, lib, config, inputs, ... }:

{
  # Enable C++ compiler and CMake support
  languages.cplusplus.enable = true;

  # Add Qt6 dependencies and package-config
  packages = [
    pkgs.pkg-config
    pkgs.qt6.qtbase
    pkgs.qt6.qtdeclarative
    pkgs.qt6.qtshadertools
    pkgs.spirv-tools
  ];

  # Helper script to compile the plugin
  scripts.build-plugin.exec = ''
    mkdir -p build
    cd build
    cmake ..
    make
  '';

  # Helper script to run the test using qml
  scripts.run-test.exec = ''
    QML_IMPORT_PATH=$(pwd)/build/imports:${pkgs.qt6.qtdeclarative}/lib/qt-6/qml qml test/test_shell.qml
  '';

  enterShell = ''
    echo "================================================="
    echo " Quickshell / QML Plugin Development Environment"
    echo " Usage:"
    echo "   devenv shell build-plugin  - Compile the plugin"
    echo "   devenv shell run-test      - Run test with quickshell"
    echo "================================================="
  '';
}
