{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    tmux
    git
    starship
    mosh
    fzf
    ripgrep
    fd
    bat
    eza
    zoxide
    cmake
    gh

    lmstudio
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
    tokei
    bottom
    dust
    procs
    sesh
    rust-analyzer
    cargo-binstall
    sccache
  ];

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    PAGER = "less -R";
    LANG = "en_US.UTF-8";
    RUSTC_WRAPPER = "sccache";
    SCCACHE_DIR = "${config.xdg.cacheHome}/sccache";
    TERMINFO_DIRS = "${pkgs.kitty}/share/terminfo:${pkgs.ncurses}/share/terminfo";
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

  programs.lazygit = {
    enable = true;
    settings = {
      git.pagers = [
        {
          colorArg = "always";
          pager = "delta --paging=never";
        }
      ];
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
    prefix = "C-Space";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      {
        plugin = minimal-tmux-status;
        extraConfig = ''
          set -g @minimal-tmux-use-arrow true
          set -g @minimal-tmux-right-arrow ""
          set -g @minimal-tmux-left-arrow ""
          set -g @minimal-tmux-status-left-extra "#([ -n \"#{IN_NIX_SHELL}\" ] && echo '❄ ' || true)"
        '';
      }
    ];

    extraConfig = ''
      set-option -g default-shell "${pkgs.nushell}/bin/nu"
      set -g allow-passthrough on
      set -ag terminal-overrides ",xterm-256color:RGB"
      setw -g pane-base-index 1
      set -ag update-environment " IN_NIX_SHELL"
      set -sg escape-time 0

      bind-key C-Space send-prefix

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r C-k swap-pane -U
      bind -r C-j swap-pane -D
      bind u split-window -v
      bind i split-window -h
      bind -r n next-window
      bind -r p previous-window

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane
      set -as terminal-features ',rxvt-unicode-256color:clipboard'
      set -s set-clipboard on


      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'

      set -g @smart-splits_resize_left_key  'M-h'
      set -g @smart-splits_resize_down_key  'M-j'
      set -g @smart-splits_resize_up_key    'M-k'
      set -g @smart-splits_resize_right_key 'M-l'
      set -g @smart-splits_resize_step_size '10'

      bind-key "t" run-shell "${pkgs.sesh}/bin/sesh connect \"$(${pkgs.sesh}/bin/sesh list --icons | ${pkgs.fzf}/bin/fzf-tmux -p 80%,70% --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' --bind 'tab:down,btab:up' --bind 'ctrl-a:change-prompt(⚡  )+reload(${pkgs.sesh}/bin/sesh list --icons)' --bind 'ctrl-t:change-prompt(🪟  )+reload(${pkgs.sesh}/bin/sesh list -t --icons)' --bind 'ctrl-g:change-prompt(⚙️  )+reload(${pkgs.sesh}/bin/sesh list -c --icons)' --bind 'ctrl-x:change-prompt(📁  )+reload(${pkgs.sesh}/bin/sesh list -z --icons)' --bind 'ctrl-f:change-prompt(🔎  )+reload(${pkgs.fd}/bin/fd -H -d 2 -t d -E .Trash . ~)' --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(${pkgs.sesh}/bin/sesh list --icons)' --preview-window 'right:55%' --preview '${pkgs.sesh}/bin/sesh preview {}')\""
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

      # Make `hyprctl` work over SSH: uwsm injects this only into the graphical
      # session, so inherit the active instance signature when it's missing.
      if [ -z "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ] && [ -n "''${XDG_RUNTIME_DIR:-}" ] && [ -d "$XDG_RUNTIME_DIR/hypr" ]; then
        export HYPRLAND_INSTANCE_SIGNATURE="$(ls "$XDG_RUNTIME_DIR/hypr" 2>/dev/null | head -n1)"
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

  programs.nushell = {
    enable = true;

    shellAliases = {
      cat = "bat";
      grep = "rg";
      find = "fd";
      g = "git";
      gst = "git status";
      gco = "git checkout";
      gcm = "git commit -m";
      gcam = "git commit -am";
    };

    extraEnv = ''
      $env.EDITOR = "nvim"
      $env.VISUAL = "nvim"
      $env.BROWSER = "firefox"
      $env.PAGER = "less -R"
      $env.LANG = "en_US.UTF-8"
      $env.PATH = ($env.PATH | prepend [$"($env.HOME)/.nix-profile/bin", "/nix/var/nix/profiles/default/bin"] | flatten)
      $env.FZF_DEFAULT_OPTS = "--height=40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      $env.TERMINFO_DIRS = $"($env.HOME)/.nix-profile/share/terminfo:/nix/var/nix/profiles/default/share/terminfo"

      # Make `hyprctl` work over SSH: uwsm injects this only into the graphical
      # session, so inherit the active instance signature when it's missing.
      if ($env.HYPRLAND_INSTANCE_SIGNATURE? | is-empty) {
        let xdg = ($env.XDG_RUNTIME_DIR? | default "")
        if ($xdg | is-not-empty) {
          let dir = ($xdg | path join "hypr")
          if ($dir | path exists) {
            $env.HYPRLAND_INSTANCE_SIGNATURE = (ls $dir | first | get name | path basename)
          }
        }
      }
    '';

    extraConfig = ''
      def hm [] { home-manager switch --flake $"($env.HOME)/.dotfiles/home-manager#main" }
      def mkcd [dir: string] { mkdir $dir; cd $dir }
    '';

    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
  };

  xdg.configFile."nushell/autoload/starship.nu".source =
    pkgs.runCommandLocal "starship-nu" { } ''
      ${pkgs.starship}/bin/starship init nu > $out
    '';

  xdg.configFile."nushell/autoload/zoxide.nu".source =
    pkgs.runCommandLocal "zoxide-nu" { } ''
      ${pkgs.zoxide}/bin/zoxide init nushell > $out
    '';

  xdg.configFile."nushell/autoload/fzf.nu".source =
    pkgs.runCommandLocal "fzf-nu" { } ''
      ${pkgs.fzf}/bin/fzf --nushell > $out
    '';

  xdg.configFile."kitty/kitty.conf".source = ./config/kitty/kitty.conf;
  xdg.configFile."nvim".source = ./config/nvim;
  xdg.configFile."hypr/user-overrides.conf".source = ./config/hypr/user-overrides.conf;
  xdg.configFile."hypr/scripts/terminal.sh" = {
    source = ./config/hypr/scripts/terminal.sh;
    executable = true;
  };
  home.file.".local/share/omarchy/default/hypr/bindings/tiling-v2.conf".source = ./config/hypr/tiling-v2.conf;

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "lmstudio"
    ];
}
