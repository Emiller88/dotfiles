# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "elevator=none" ];

  ## CPU
  nix.maxJobs = lib.mkDefault 12;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = true;

  ## GPU
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  # Respect XDG conventions, damn it!
  environment.systemPackages = with pkgs;
    [
      (writeScriptBin "nvidia-settings" ''
        #!${stdenv.shell}
        exec ${config.boot.kernelPackages.nvidia_x11}/bin/nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"
      '')
    ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
  services.blueman.enable = true;

  ## ZFS
  networking.hostId = "12a28d45";
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.grub.copyKernels = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  fileSystems."/" = {
    device = "tank/system/root";
    fsType = "zfs";
  };

  fileSystems."/var" = {
    device = "tank/system/var";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "tank/local/nix";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "tank/user/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5216-74C6";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/bd5404de-c7bb-46c9-b78a-36a8e17d77ac"; }];

  services.xserver.xrandrHeads = [{
    output = "DP-0";
    primary = true;
    monitorConfig = ''
      DisplaySize 1920 1080
      Option "dpi" "110"
    '';
  }];
}
