{ inputs, withSystem, ... }:
let
  linux = "x86_64-linux";
in
{
  flake.nixosConfigurations.catharsis = inputs.nixpkgs.lib.nixosSystem {
    system = linux;
    modules = [
      ./configuration.nix
      inputs.stylix.nixosModules.stylix
      inputs.determinate.nixosModules.default
    ];
  };

  flake.homeConfigurations."hsyed@catharsis" = withSystem linux (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home
        inputs.stylix.homeModules.stylix
      ];
      extraSpecialArgs = { inherit inputs; };
    }
  );
}
