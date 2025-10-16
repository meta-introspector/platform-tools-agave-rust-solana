{
  inputs = {
    nixpkgs.url = "github:meta-introspector/nixpkgs?ref=feature/CRQ-016-nixify";
    rust-overlay.url = "github:meta-introspector/rust-overlay?ref=feature/CRQ-016-nixify";
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      pkgs = import nixpkgs { system = "aarch64-linux"; overlays = [ rust-overlay.overlays.default ]; };
    in
    {
      packages.aarch64-linux.rustc_direct = pkgs.rustc;
      packages.aarch64-linux.cargo_direct = pkgs.cargo;
      packages.aarch64-linux.rustc_nightly_channel = pkgs.rustChannels.nightly.rustc;
      packages.aarch64-linux.cargo_nightly_channel = pkgs.rustChannels.nightly.cargo;
    };
}
