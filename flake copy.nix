{
  description = "Chehab Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS System configs and software, including fonts
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # tricked out nvim
    pwnvim.url = "github:zmre/pwnvim";
  };

  outputs = inputs@{ self, darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        nix.linux-builder.enable = true;

        nix.extraOptions = ''
          extra-platforms = x86_64-darwin aarch64-darwin
        '';

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        services.nix-daemon.enable = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        # environment.systemPackages = [
        #   pkgs.vim
        # ];

        systemPackages = [ pkgs.vim pkgs.coreutils ];

        fonts.fontDir.enable = false; # true will remove installed font
        fonts.fonts = [ pkgs.nerdFonts ];


        # Auto upgrade nix package and the daemon service.
        # nix.package = pkgs.nix;

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;  # default shell on catalina
        # programs.fish.enable = true;

        environment.shells = [ pkgs.bash pkgs.zsh ];

        security.pam.enableSudoTouchIdAuth = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        home-manger = {
          useGlobalPkgs = true;
          useUserPkgs = true;
          users."chehabmustafa-hilmy".imports = [
            ({ pkgs, ... }: {

              home.packages = [
                pkgs.ripgrep
                pkgs.fd
                pkgs.less
                inputs.pwnvim.packages."aarch64-darwin".default
              ];

              home.sessionVariables = {
                PAGER = "less";
                CLICOLOR = 1;
                EDITOR = "nvim";
              };
              programs.bat.enabled = true;
              programs.bat.config.them = "TwoDark";

              programs.exa.enable = true;
              programs.eza.enable = true;
              programs.git.enable = true;

              programs.zsh = {
                enable = true;
                enableCompletion = true;
                enableAutosuggestions = true;
                enableSyntaxHighlight = true;
              };

              programs.fzf = {
                enable = true;
                enableZshIntegration = true;
              };

              programs.alacritty = {
                enable = true;
                settings.font.normal.family = "MesloLGS Nerd Font Mono";
                settings.font.size = 16;
              };

              programs.zsh.shellAliases = {
              ll = "eza --icons -s=name --group-directories-first  ";
              };
            })
          ];
        };

        system.defaults = {
          # Dock
          dock.autohide = true;
          dock.mru-spaces = false;
          dock.mineffect = "scale";
          dock.show-recents = false;
          dock.minimize-to-application = true;
          dock.mouse-over-hilite-stack = true;
          # Finder
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "clmv";
          finder.FXDefaultSearchScope = "SCcf"; # search current folder
          finder.ShowPathbar = true;
          finder.ShowStatusBar = true;
          # menu lets
          menuExtraClock.Show24Hour = true;
          # login
          loginwindow.LoginwindowText = "بسم الله";
          # screencapture
          screencapture.location = "~/Pictures/screenshots";
          # screensaver
          screensaver.askForPasswordDelay = 10;
          # trackpad
          trackpad.Clicking = true;
          trackpad.TrackpadThreeFingerDrag = true;
        };

        homebrew = {
          enable = true;
          caskArgs.no_quarantine = true;
          masApps = {};
          taps = [ "nikitabobko/tap" ];
          casks = ["raycast" "aerospace"];
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."Chehab-MBP-X2" = darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Chehab-MBP-X2".pkgs;
    };
}
