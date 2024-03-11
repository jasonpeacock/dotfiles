{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

    tmux.enableShellIntegration = true;

    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

    defaultCommand = "fd --type f";
    defaultOptions = ["--height 40%" "--border"];

    fileWidgetCommand = "fd --type f";
    # fileWidgetOptions = [ "--preview 'bat --style=plain --theme \'Dracula\' {}'" ];
    fileWidgetOptions = [ "--preview 'bat --style=plain --theme \'Nord\' {}'" ];

    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
