{ inputs, withSystem, ... }:
let
  darwin = "aarch64-darwin";
in
{
  flake.darwinConfigurations.personal = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      ./configuration.nix
      inputs.determinate.darwinModules.default
    ];
  };

  flake.homeConfigurations."hsyed@personal" = withSystem darwin (
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
