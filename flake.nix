{
  description = "flake to declarative use wallpapers in the current repo";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {inherit system;};

        name = "flake-wallpaper";
        packages.default = with pkgs;
          stdenv.mkDerivation
          rec {
            pname = "flake-wallpaper";
            version = "0.0.0";

            src = ./.;

            buildInputs = [
            ];

            installPhase = ''
              mkdir -p $out/share/wallpapers/kanagawa-dragon
              mkdir $out/share/wallpapers/kanagawa-wave
              cp -r $src/kanagawa-wave/ $out/share/wallpapers/
              cp -r $src/kanagawa-dragon/ $out/share/wallpapers/
            '';

            meta.mainProgram = "${pname}";
          };
      }
    );
}
