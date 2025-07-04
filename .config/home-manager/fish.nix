{pkgs, ...}: {
  programs.fish = {
    enable = true;
    # shellInit = builtins.readFile fish/shellInit.fish;
    loginShellInit = builtins.readFile fish/loginShellInit.fish;
    # interactiveShellInit = builtins.readFile fish/interactiveShellInit.fish;
    interactiveShellInit = "
theme_gruvbox dark soft
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

      # Emulate !! and !$ from Bash
      # https://github.com/fish-shell/fish-shell/wiki/Bash-Style-Command-Substitution-and-Chaining-(!!-!$)
      bind_bang = "
switch (commandline -t)
case \"!\"
  commandline -t -- $history[1]
  commandline -f repaint
case \"*\"
  commandline -i !
end
    ";

      bind_dollar = "
switch (commandline -t)
# Variation on the original, vanilla \"!\" case
# ===========================================
#
# If the `!$` is preceded by text, search backward for tokens that
# contain that text as a substring. E.g., if we'd previously run
#
#   git checkout -b a_feature_branch
#   git checkout main
#
# then the `fea!$` in the following would be replaced with
# `a_feature_branch`
#
#   git branch -d fea!$
#
# and our command line would look like
#
#   git branch -d a_feature_branch
#
case \"*!\"
  commandline -f backward-delete-char history-token-search-backward
case \"*\"
  commandline -i '$'
end
      ";

      fish_user_key_bindings = "
bind ! bind_bang
bind '$' bind_dollar
      ";
    };
    shellAliases = {
      bc = "bc -l -q \"\$HOME/.bc\"";
      cdp = "cd (pwd -P)";
      et-cloud = "et cloud --terminal-path \"~/.nix-profile/bin/etterminal\" -c \"tmux\"";
      grep = "grep --color=auto";
      gs = "scmpuff_status";
      http = "python3 -m http.server";
      less = "less -R -n";
      ls = "eza --group --git --group-directories-first";
      mwe = "mw && exit";
      scp = "scp -C";
      tmux = "tmux new -As0";
      tree = "eza --tree --git";
      vi = "nvim -o";
      work = "cd \"$HOME/workplace\"";
    };
    plugins = [
      # Bring in `fenv` for sourcing files from other shells (like Zsh).
      # Need to add the plugin here, and not in `home.nix` b/c we need to
      # access `fenv` in the init scripts of Fish during shell initialization.
      {
        name = "foreign-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
      {
        name = "gruvbox";
        src = pkgs.fishPlugins.gruvbox.src;
      }
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
