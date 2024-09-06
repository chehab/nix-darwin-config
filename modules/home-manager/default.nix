{ pkgs, pwnvim, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "24.11";

  home.file.".inputrc".source = ./dotfiles/inputrc;

  # specify home-manager configs
  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    pwnvim.packages."aarch64-darwin".default
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  programs = {
    # A
    alacritty = {
      enable = true;
      settings.font.normal.family = "MesloLGS Nerd Font Mono";
      settings.font.size = 16;
    };
    # B
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
    # C
    # D
    # E
    eza.enable = true;
    # F
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    # G
    git = {
      enable = true;
      userEmail = "m@chehab.me";
      userName = "Chehab Abdelhamed";
    };
    # H
    home-manager.enable = true;
    # J
    # K
    # L
    # M
    # N
    # O
    # P
    # Q
    # R
    # S
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    # T
    # U
    # V
    # W
    # X
    # Y
    # Z
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "ls --color=auto -F";
        ll = "eza --icons -s=name --group-directories-first  ";
        nixswitch = "darwin-rebuild switch --flake ~/.config/nix-darwin-config/.#";
        nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
      };
    };
  };
}
