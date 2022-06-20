{ pkgs, ... }:

{
  programs.fzf = {
    enable = false;
    enableFishIntegration = true;

    tmux.enableShellIntegration = true;

    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

    defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];

    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'bat --style=plain --theme \'Dracula\' {}'" ];

    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
