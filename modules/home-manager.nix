{ config, lib, ... }:

let
  pkg = (import ../default.nix { }).nvim;
  cfg = config.programs.nvim-rx;

  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    attrsets
    ;
in
{
  options.programs.nvim-rx = {
    enable = mkEnableOption "rx342 nvim";
    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to configure {command}`nvim` as the default
        editor using the {env}`EDITOR` environment variable.
      '';
    };
    viewAlias = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Alias {command}`view` to {command}`nvim -R`.
      '';
    };
    vimdiffAlias = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Alias {command}`vimdiff` to {command}`nvim -d`.
      '';
    };
    rxAliases = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable rx342 opiniated custom aliases.
      '';
    };
    integrations = {
      git = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable git integrations.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkg ];

    home.sessionVariables = mkIf cfg.defaultEditor { EDITOR = "nvim"; };

    home.shellAliases =
      (attrsets.optionalAttrs cfg.vimdiffAlias { vimdiff = "nvim -d"; })
      // (attrsets.optionalAttrs cfg.viewAlias { view = "nvim -R"; })
      // (attrsets.optionalAttrs cfg.rxAliases {
        e = "nvim";
        v = "nvim -R";
      });

    programs.git.extraConfig = mkIf cfg.integrations.git {
      core.editor = "nvim";
      merge = {
        tool = "nvim";
      };
      mergetool = {
        nvim.cmd = "nvim $MERGED";
      };
    };
  };
}
