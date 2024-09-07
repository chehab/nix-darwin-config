{ pkgs, ... }: {
  services.nix-daemon.enable = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs.zsh.enable = strue;

  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
    systemPackages = with pkgs; [
      coreutils
      sublime4
      sublime-merge
      jetbrains-toolbox
      jetbrains.webstorms
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  # backwards compat; don't change
  system.stateVersion = 4;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = false;
  };

  system.defaults = {
    # A
    # B
    # C
    # D
    dock = {
      autohide = true;
      mru-spaces = false;
      mineffect = "scale";
      show-recents = false;
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
    };
    # E
    # F
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXPreferredViewStyle = "clmv";
      FXDefaultSearchScope = "SCcf"; # search current folder
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    # G
    # H
    # I
    # J
    # K
    # L
    loginwindow = {
      LoginwindowText = "بسم الله";
    };
    # M
    menuExtraClock = {
      Show24Hour = true;
    };
    # N
    NSGlobalDomain = {
      KeyRepeat = 1;
      InitialKeyRepeat = 14;
      AppleShowAllExtensions = true;
    };
    # O
    # P
    # Q
    # R
    # S
    screencapture = {
      location = "~/Pictures/screenshots";
    };
    screensaver = {
      askForPasswordDelay = 10;
    };
    # T
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
    # U
    # V
    # X
    # Y
    # Z
  };

  #fonts.packages = with pkgs; [ nerdFonts ];

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    taps = [ "nikitabobko/tap" "fujiapple852/trippy" ];
    brews = [ "trippy" ];
    casks = [
      "arc"
      "aerospace"
      "affinity-designer"
      "affinity-photoss"
      "amethyst"
      "fork"
      "linear-linear"
      "raycast"
      "setapp"
      "proton-drive"
      "proton-mail"
      "proton-pass"
      "proton-vpn"
      "vcam"
    ];
  };
}
