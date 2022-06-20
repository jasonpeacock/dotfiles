# Source Nix setup script
fenv source $HOME/.nix-profile/etc/profile.d/nix.sh

# Set directory colors from `ls` to Dracula theme
set -gx LS_COLORS (vivid generate dracula)

# Use Neovim as the default $EDITOR.
set -gx EDITOR \"nvim\"

#
# Load host-specific configuration.
#
set THIS_HOST (hostname | sed 's/\\..*$//')
if test -f $HOME/.zsh/$THIS_HOST.zshrc
    fenv source $HOME/.zsh/$THIS_HOST.zshrc
    fish_add_path $HOME/.$THIS_HOST-bin
    fish_add_path $HOME/.cargo/bin
else
    echo \"*** No host-specific file found! Expected [$HOME/.zsh/$THIS_BOX.zshrc] ***\"
end

#
# Dotfile management with homeshick.
#
if test -d $HOME/.homesick
  source $HOME/.homesick/repos/homeshick/homeshick.fish
  source $HOME/.homesick/repos/homeshick/completions/homeshick.fish
end
