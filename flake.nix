{
  description = "Home Manager configuration of hsyed";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Pinned to 3.22: 3.23 emits activity type 10113, which breaks nom 2.2.0 (see FIX-FORWARD.md).
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3.22.*";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Zed's Delta: not in nixpkgs yet, see FIX-FORWARD.md
    delta = {
      url = "github:zed-industries/delta-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.nix-darwin.flakeModules.default
        ./hosts/nixos/catharsis
        ./hosts/darwin/personal
        ./hosts/darwin/work
      ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
        };
    };
}
