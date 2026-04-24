{
  description = "Home Manager configuration of hsyed";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      determinate,
      nix-darwin,
      ...
    }:
    let
      linuxSystem = "x86_64-linux";
      supportedFormatterSystems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      pkgs = nixpkgs.legacyPackages.${linuxSystem};
      pkgsDarwin = nixpkgs.legacyPackages."aarch64-darwin";
    in
    {
      formatter = nixpkgs.lib.genAttrs supportedFormatterSystems (
        system: nixpkgs.legacyPackages.${system}.nixfmt-tree
      );

      nixosConfigurations = {
        "catharsis" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/catharsis/configuration.nix
            stylix.nixosModules.stylix
            determinate.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "hsyed@catharsis" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home/home.nix
            ./home/dev.nix
            ./home/hyprland
            stylix.homeModules.stylix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };

      darwinConfigurations = {
        "personal" = nix-darwin.lib.darwinSystem {
          modules = [
            ./system/darwin.nix
            determinate.darwinModules.default
            {
              networking.hostName = "personal";
              networking.computerName = "Hassans Macbook";
            }
          ];
        };
      };

      homeConfigurations = {
        "hsyed@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsDarwin;
          modules = [
            ./home/home.nix
            ./home/dev.nix
            ./home/darwin
            stylix.homeModules.stylix
          ];
        };
      };
    };
}
