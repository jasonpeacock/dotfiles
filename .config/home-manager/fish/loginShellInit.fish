# Source Nix setup script.
if test -f $HOME/.nix-profile/etc/profile.d/nix.sh
    fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
else
    echo >&2 "Nix setup [$HOME/.nix-profile/etc/profile.d/nix.sh] is missing"
end

# Set directory colors from `ls`
#set -gx LS_COLORS (vivid generate dracula)
#set -gx LS_COLORS (vivid generate nord)
set -gx LS_COLORS (vivid generate solarized-light)

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
