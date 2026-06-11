{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    tmux
    git
    starship
    fzf
    ripgrep
    fd
    bat
    eza
    zoxide

    nushell
    kitty
    yazi
    opencode
    htop
    btop
    curl
    wget
    unzip
    tree
    jq
    delta
    tokei
    bottom
    dust
    procs
    lazygit
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    PAGER = "less -R";
    LANG = "en_US.UTF-8";
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Alfred Bendrup";
        email = "me@alfredbendrup.me";

      };
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit -m";
        cam = "commit -am";
      };
    };
  };

  programs.delta = {
    enable = true;
    options = {
      theme = "Catppuccin Mocha";
      line-numbers = true;
      side-by-side = true;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$line_break$character";

      character = {
        success_symbol = "[❯](bold mauve)";
        error_symbol = "[❯](bold red)";
      };

      directory = {
        style = "bold blue";
        truncate_to_repo = false;
      };

      git_branch = {
        style = "bold purple";
      };
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind | split-window -h
      bind - split-window -v
    '';
  };

 programs.bash = {
    enable = true;

    shellAliases = {
      hm = "home-manager switch --flake ~/.dotfiles/home-manager#main";

      # ls replacements
      ls = "eza --icons";
      ll = "eza -la --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";

      cat = "bat";
      grep = "rg";
      find = "fd";

      g = "git";
      gst = "git status";
      gco = "git checkout";
      gcm = "git commit -m";
      gcam = "git commit -am";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    initExtra = ''
      # CRITICAL: Ensure Nix binaries are in PATH
      export PATH="$HOME/.nix-profile/bin:$PATH"

      # Source Nix daemon script if it exists (for multi-user installs)
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      # Initialize starship prompt
      eval "$(starship init bash)"

      # Initialize zoxide
      eval "$(zoxide init bash)"

      # Include Omarchy bash layer (v2.1.x ships a ~/.bashrc that sources this)
      if [ -f "$HOME/.local/share/omarchy/default/bash/rc" ]; then
        . "$HOME/.local/share/omarchy/default/bash/rc"
      fi

      # Custom functions
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      # Better cd with zoxide fallback
      cd() {
        if [ -d "$1" ] || [ -z "$1" ]; then
          builtin cd "$@"
        else
          z "$@"
        fi
      }
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
  };

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;
}
