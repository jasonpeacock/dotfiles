# Source Nix setup script.
if test -f $HOME/.nix-profile/etc/profile.d/nix.sh
    fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
else
    echo >&2 "Nix setup [$HOME/.nix-profile/etc/profile.d/nix.sh] is missing"
end

# Set directory colors from `ls` to Dracula theme.
set -gx LS_COLORS (vivid generate dracula)

# Use Neovim as the default $EDITOR.
set -gx EDITOR \"nvim\"

# Cargo/rust support for all hosts.
fish_add_path $HOME/.cargo/bin

# Load host-specific configuration.
set THIS_HOST (hostname | sed 's/\\..*$//')
if test -f $HOME/.config/host-init/$THIS_HOST.fish
    source $HOME/.config/host-init/$THIS_HOST.fish
    fish_add_path $HOME/.$THIS_HOST-bin
else
    echo >&2 "No host-specific file found! Expected [$HOME/.config/host-init/$THIS_HOST.fish]"
end

# Dotfile management with homeshick.
if test -d $HOME/.homesick
  source $HOME/.homesick/repos/homeshick/homeshick.fish
  source $HOME/.homesick/repos/homeshick/completions/homeshick.fish
end
