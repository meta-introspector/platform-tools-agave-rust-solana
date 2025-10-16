{
  description = "Solana Platform Tools (Agave Rust)";

  inputs = {
    nixpkgs.url = "github:meta-introspector/nixpkgs?ref=feature/CRQ-016-nixify";
    flake-utils.url = "github:meta-introspector/flake-utils?ref=feature/CRQ-016-nixify";

    cargo-build-bpf.url = "github:meta-introspector/solana-flake?ref=feature/CRQ-016-nixify&dir=cargo-build-bpf";
    solana-bpf-tools.url = "github:meta-introspector/solana-flake?ref=feature/CRQ-016-nixify&dir=solana-bpf-tools";
    solana-cli.url = "github:meta-introspector/solana-flake?ref=feature/CRQ-016-nixify&dir=solana-cli";
  };

  outputs = { self, nixpkgs, flake-utils, cargo-build-bpf, solana-bpf-tools, solana-cli }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        packages.default = pkgs.buildEnv {
          name = "solana-platform-tools";
          paths = [
            cargo-build-bpf.packages.${system}.default
            solana-bpf-tools.packages.${system}.default
            solana-cli.packages.${system}.default
          ];
        };

        devShells.default = pkgs.mkShellNoCC {
          packages = [
            packages.default
          ];
        };
      });
}
