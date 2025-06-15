{
  description = "rx342 neovim dotfiles";

  outputs =
    { self, ... }:
    let
      system = "x86_64-linux";
      nvim-rx = import ./default.nix { inherit system; };
    in
    {
      packages.${system} = {
        inherit (nvim-rx) nvim;
        default = self.packages.${system}.nvim;
      };

      inherit (nvim-rx) homeModules;
    };
}
