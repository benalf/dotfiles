if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export KITTY_ENABLE_WAYLAND=1

# opam configuration
source /home/alf/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/alf/.local/share/coursier/bin"
# <<< coursier install directory <<<
