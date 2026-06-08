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
      url = "github:nix-darwin/nix-darwin/master";
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

      #############################################################################
      ###                               catharsis                               ###
      #############################################################################
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
            {
              home.username = "hsyed";
              home.homeDirectory = "/home/hsyed";
            }
            ./home/home.nix
            ./home/dev
            ./home/hyprland
            stylix.homeModules.stylix
          ];
        };
      };

      #############################################################################
      ###                               personal                                ###
      #############################################################################
      darwinConfigurations = {
        "personal" = nix-darwin.lib.darwinSystem {
          modules = [
            ./system/darwin/common.nix
            ./system/darwin/personal.nix
            determinate.darwinModules.default
          ];
        };
      };

      homeConfigurations = {
        "hsyed@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsDarwin;
          modules = [
            {
              home.username = "hsyed";
              home.homeDirectory = "/Users/hsyed";
            }
            ./home/home.nix
            ./home/dev
            ./home/darwin
            stylix.homeModules.stylix
          ];
        };
      };

      #############################################################################
      ###                                 work                                  ###
      #############################################################################
      darwinConfigurations = {
        "work" = nix-darwin.lib.darwinSystem {
          modules = [
            ./system/darwin/common.nix
            ./system/darwin/work.nix
            determinate.darwinModules.default
          ];
        };
      };

      homeConfigurations = {
        "hassan.syed@work" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsDarwin;
          modules = [
            {
              home.username = "hassan.syed";
              home.homeDirectory = "/Users/hassan.syed";
            }
            ./home/home.nix
            ./home/dev
            ./home/darwin
            stylix.homeModules.stylix
          ];
        };
      };
    };
}
