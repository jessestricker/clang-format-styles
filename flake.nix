{
  description = "The built-in styles of clang-format.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      llvmPackages = pkgs.llvmPackages_14;
      clang-tools = pkgs.clang-tools.override {inherit llvmPackages;};
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        pname = "clang-format-styles";
        version = clang-tools.version;
        buildInputs = [clang-tools];

        src = ./.;
        builder = ./builder.sh;
      };
    });
}
