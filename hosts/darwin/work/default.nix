{ inputs, withSystem, ... }:
let
  darwin = "aarch64-darwin";
in
{
  flake.darwinConfigurations."Hassan-Syed-GHKP276W2K" = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      ./configuration.nix
      inputs.determinate.darwinModules.default
    ];
  };

  flake.homeConfigurations."hassan.syed@Hassan-Syed-GHKP276W2K" = withSystem darwin (
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
