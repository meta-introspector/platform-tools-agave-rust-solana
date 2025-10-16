{
  description = "Solana Platform Tools (Agave Rust)";

  inputs = {
    nixpkgs.url = "github:meta-introspector/nixpkgs?ref=feature/CRQ-016-nixify";
    flake-utils.url = "github:meta-introspector/flake-utils?ref=feature/CRQ-016-nixify";
    rust-src.url = "./vendor/rust-src";
    cargo-src.url = "./vendor/cargo-src";
    newlib-src.url = "./vendor/newlib-src";
  };

  outputs = { self, nixpkgs, flake-utils, rust-src, cargo-src, newlib-src }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        packages.default = pkgs.buildEnv {
          name = "solana-platform-tools";
          paths = [
            # These will be defined as derivations later
          ];
        };

        devShells.default = pkgs.mkShellNoCC {
          packages = [
            packages.default
          ];
        };
      });
}
