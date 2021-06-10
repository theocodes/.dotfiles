{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  # allow non-free
  nixpkgs.config.allowUnfree = true;

  # enable re-indexing of installed fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # core tools
    stow
    gnumake
    ripgrep
    p7zip
    dig

    # fonts
    jetbrains-mono
  ];

  imports = [
    ./modules/cli.nix
    ./modules/editors.nix
    ./modules/dev.nix
  ];

  home.username = "tfelippe";
  home.homeDirectory = "/home/tfelippe";

  home.stateVersion = "21.05"; # do not change!
}
