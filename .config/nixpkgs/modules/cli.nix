{ config, lib, pkgs, ... }:

{
  home.sessionPath = [
    "$HOME/scripts"
  ];

  home.packages = with pkgs; [
    # ls replacement
    exa

    # data
    jq yq
  ];

  programs.fish = {
    enable = true;

    shellAbbrs = {
      rel = "exec $SHELL";
      vim = "nvim";
    };

    shellAliases = {
      ll = "exa -la";
    };

    interactiveShellInit = ''
      function fish_greeting; end
    '';

    functions = {
      signin = "eval (op signin felippe.1password.com)";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
