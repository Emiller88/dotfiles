{ config, options, lib, pkgs, ... }:
with lib; {
  imports = [ ./common.nix ];

  options.modules.desktop.stumpwm = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.stumpwm.enable {
    environment.systemPackages = with pkgs; [ lightdm dunst libnotify ];

    services = {
      redshift.enable = true;
      picom.enable = true;
      xserver = {
        enable = true;
        displayManager.defaultSession = "none+stumpwm";
        displayManager.lightdm.enable = true;
        displayManager.lightdm.greeters.mini.enable = true;
        windowManager.stumpwm.enable = true;
      };
    };

    # link recursively so other modules can link files in their folders
    my.home.xdg.configFile."stumpwm" = {
      source = <config/stumpwm>;
      recursive = true;
    };
  };
}
