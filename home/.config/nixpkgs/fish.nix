{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    # shellInit = builtins.readFile "./fish/shellInit.fish";
    shellInit = "
    ";
    # loginShellInit = builtins.readFile "./fish/loginShellInit.fish";
    loginShellInit = "
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
    ";
    # interactiveShellInit = builtins.readFile "./fish/interactiveShellInit.fish";
    interactiveShellInit = "
starship init fish | source

    ";
    functions = {
      # Initialize directory to run a local nix-shell.
      nixify = "
if test -f ./.envrc
  echo >&2 \"File already exists: [.envrc]\"
  return 1
end

echo \"use nix\" > .envrc
${pkgs.direnv}/bin/direnv allow

echo \"\\
with import <nixpkgs> {};
stdenv.mkDerivation {
name = \\\"env\\\";
buildInputs = [
  bashInteractive
];
}\\
\" > default.nix

\$EDITOR default.nix
      ";

      # Initialize directory to run a local python version.
      pythonify = "
if test -f ./.envrc
  echo >&2 \"File already exists: [.envrc]\"
  return 1
end

echo \"layout python3\" > .envrc
${pkgs.direnv}/bin/direnv allow
      ";
    };
    shellAliases = {
      bc="bc -l -q \"\$HOME/.bc\"";
      grep="grep --color=auto";
      http="python3 -m http.server";
      less="less -R -n";
      ls="exa --icons --git";
      scp="scp -C";
      tmux="tmux new -As0";
      tree="exa --tree --icons --git";
      vi="nvim -o";
      work="cd \"$HOME/workplace\"";
    };
    plugins = [
      # Bring in `fenv` for sourcing files from other shells (like Zsh).
      # Need to add the plugin here, and not in `home.nix` b/c we need to
      # access `fenv` in the init scripts of Fish during shell initialization.
      { name = "foreign-env"; src = pkgs.fishPlugins.foreign-env.src; }
      # Example of loading a plugin from source repo:
      # {
      #   name = "z";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jethrokuan";
      #     repo = "z";
      #     rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
      #     sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
      #   };
      # }
    ];
  };
}
