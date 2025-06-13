{
  description = "rx342 neovim dotfiles";

  outputs =
    { self, ... }:
    let
      system = "x86_64-linux";
    in
    {
      packages.${system} = {
        nvim = import ./default.nix { inherit system; };
        default = self.packages.${system}.nvim;
      };
    };
}
