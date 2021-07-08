{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  defaultUser = "tfelippe";
  syschdemd = import ./syschdemd.nix { inherit lib pkgs config defaultUser; };
in {
  imports = [ "${modulesPath}/profiles/minimal.nix" ];

  # WSL is closer to a container than anything else
  boot.isContainer = true;

  environment.etc.hosts.enable = false;
  environment.etc."resolv.conf".enable = false;

  networking.dhcpcd.enable = false;

  nixpkgs.config.allowUnfree = true;
  services.localtime.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    gnumake
    stow
    ripgrep
  ];

  users.users.tfelippe = {
    isNormalUser = true;
    hashedPassword =
      "$6$nCMdQaHrRiC0W$KTsvDnO7.bu6MBKR9Nl4wabZkH5AdwFBLCrmY7Cmn88g3gpO7X9qEDFPLJQlbU.qPTHiTt196/IeZdtJdSlMz0";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  #users.users.${defaultUser} = {
  #  isNormalUser = true;
  #  extraGroups = [ "wheel" ];
  #};

  networking = { hostName = "hades"; };

  environment.noXlibs = lib.mkForce false;

  users.users.root = {
    shell = "${syschdemd}/bin/syschdemd";
    # Otherwise WSL fails to login as root with "initgroups failed 5"
    extraGroups = [ "root" ];
  };

  # Prepare for flake
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  security.sudo.wheelNeedsPassword = false;

  # Disable systemd units that don't make sense on WSL
  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;

  systemd.services.firewall.enable = false;
  systemd.services.systemd-resolved.enable = false;
  systemd.services.systemd-udevd.enable = false;

  # TODO move this
  fonts.fonts = with pkgs; [ jetbrains-mono cascadia-code font-awesome ];

  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;
}
