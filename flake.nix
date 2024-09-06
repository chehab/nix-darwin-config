{
  description = "Chehab macOS system flake";

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

  outputs = inputs@{ nixpkgs, home-manager, darwin, pwnvim, ... }: {
      darwinConfigurations.Chehab-MBP-X2 = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            users.users.chehabmustafa-hilmy.home = "/Users/chehabmustafa-hilmy";

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit pwnvim; };
              # homeDirectory = "/Users/chehabmustafa-hilmy";
              users.chehabmustafa-hilmy.imports = [ ./modules/home-manager ];
            };
          }
        ];
      };

      darwinConfigurations.Chehab-MBP-RD = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit pwnvim; };
              users.chehab.imports = [ ./modules/home-manager ];
            };
          }
        ];
      };
    };
}
