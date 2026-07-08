{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      userConfigs = {
        main = {
          username = "alf";
          homeDirectory = "/home/alf";
        };
      };

      mkHomeConfig = name: config:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home.nix
            {
              home = {
                inherit (config) username homeDirectory;
                stateVersion = "24.11";
              };

              home.file.".config/omarchy".enable = false;
              home.file.".config/nvim".enable = false;
              home.file.".config/tmux".enable = false;
              home.file.".config/hypr".enable = false;
              home.file.".config/alacritty".enable = false;
              home.file.".config/btop/themes".enable = false;
            }
          ];
        };
    in {
      homeConfigurations = builtins.mapAttrs mkHomeConfig userConfigs;
    };
}

