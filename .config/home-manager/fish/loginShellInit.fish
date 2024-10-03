# Source Nix setup script.
if test -f /etc/profile.d/nix.sh
    # Modern Nix installation path
    fenv source /etc/profile.d/nix.sh
else if test -f $HOME/.nix-profile/etc/profile.d/nix.sh
    # Legacy Nix installation path
    fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
else
    echo >&2 "Nix setup script is missing"
end

# Explicitly set the SHELL so TMUX does the right thing.
set -gx SHELL /Users/jasonpeacock/.nix-profile/bin/fish

# Set directory colors from `ls`
set -gx LS_COLORS (vivid generate solarized-dark)

# Cargo/rust support for all hosts.
fish_add_path $HOME/.cargo/bin

# pipx support for all hosts.
fish_add_path $HOME/.local/bin

# Load host-specific configuration.
set THIS_HOST (hostname | sed 's/\\..*$//')
if test -f $HOME/.config/host-init/$THIS_HOST.fish
    source $HOME/.config/host-init/$THIS_HOST.fish
    fish_add_path $HOME/.bin
else
    echo >&2 "No host-specific file found! Expected [$HOME/.config/host-init/$THIS_HOST.fish]"
end
