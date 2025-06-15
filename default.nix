{
  system ? builtins.currentSystem,
  source ? import ./npins,
  pkgs ? import source.nixpkgs {
    overlays = [ ];
    config = { };
    inherit system;
  },
  mnw ? import source.mnw,
}:

{
  nvim = pkgs.callPackage ./packages/nvim.nix { inherit mnw; };
  homeModules.default = ./modules/home-manager.nix;
}
