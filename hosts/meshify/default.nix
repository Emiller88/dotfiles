{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  modules = {
    desktop = {
      bspwm.enable = true;

      apps.rofi.enable = true;
      apps.discord.enable = true;

      browsers = {
        default = "firefox";
        firefox.enable = true;
      };

      gaming.steam.enable = true;

      media = {
        documents.enable = true;
        graphics.enable = true;
        mpv.enable = true;
        ncmpcpp.enable = true;
        recording.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
    };

    editors = {
      default = "emacs -nw";
      emacs.enable = true;
      vim.enable = true;
    };
    hardware = {
      audio.enable = true;
      ergodox.enable = true;
      fs = {
        enable = true;
        zfs.enable = true;
        ssd.enable = true;
      };
      nvidia.enable = true;
      sensors.enable = true;
    };
    dev = {
      cc.enable = true;
      clojure.enable = true;
      common-lisp.enable = true;
      nixlang.enable = true;
      node.enable = true;
      python.enable = true;
      R.enable = true;
      rust.enable = true;
    };

    shell = {
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      pass.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };

    services = {
      # calibre.enable = true;
      docker.enable = true;
      keybase.enable = true;
      mpd.enable = true;
      # pia.enable = true;
      ssh.enable = true;
      # ssh-agent.enable = true;
      syncthing.enable = true;
      transmission.enable = true;
    };

    themes.functional.enable = true;
  };

  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  boot.loader.systemd-boot.enable = true;
  networking.hostId = "3b848ba1";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  # hiDPI
  services.xserver.dpi = 192;
  fonts.fontconfig.hinting.enable = false;

  # ZFS
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.grub.copyKernels = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  services.znapzend = {
    enable = true;
    autoCreation = true;
    zetup = {
      "tank/user/home" = {
        plan = "1d=>1h,1m=>1d,1y=>1m";
        recursive = true;
        destinations.local = { dataset = "bigdata/backup"; };
      };
    };
  };
}
