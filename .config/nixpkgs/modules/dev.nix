{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # tools
    awscli github-cli kubectl
    exercism _1password
  ];

  # nix-shell replacement
  services.lorri.enable = true;

  # load per-project nix-shell env
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
}
