{
  description = "Blobby QML Plugin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
        blobby = pkgs.cmake.build {
          pname = "blobby";
          version = "1.0";

          src = ./.;

          nativeBuildInputs = with pkgs; [
            cmake
            pkg-config
            qt6.wrapCMake
          ];

          buildInputs = with pkgs; [
            qt6.qtbase
            qt6.qtdeclarative
            qt6.qtshadertools
            spirv-tools
          ];
        };
      in
      {
        packages.default = blobby;
        packages.blobby = blobby;
        qmlImportPath = "${blobby}/lib/qt6/qml";
      });
}
