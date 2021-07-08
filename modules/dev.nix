{ config, lib, pkgs, ... }: {
  # daemon to manage per-project env dependencies
  services.lorri.enable = true;

  environment.systemPackages = with pkgs; [
    # per-project environment loader
    direnv

    # tools
    awscli
    github-cli
    kubectl
    exercism

    # golang
    go_1_16
    goimports
    gopls
    godef

    # rust
    rustup
    rust-analyzer

    # elixir
    elixir

    # python
    python39

    # nix
    nixfmt

    # sh
    shfmt

    # web debugging proxy
    charles
  ];
}
