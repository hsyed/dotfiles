{ inputs, ... }:
{
  imports = [
    ./identity.nix
    "${inputs.self}/home/home.nix"
    "${inputs.self}/home/dev"
    "${inputs.self}/home/darwin"
  ];
}
