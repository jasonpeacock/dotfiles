{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

    tmux.enableShellIntegration = true;

    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

    defaultCommand = "fd --type f";
    # Catppuccin Mocha theme:
    # https://github.com/catppuccin/fzf
    defaultOptions = [ "--height 40%" "--border" "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8" "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc" "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"];

    fileWidgetCommand = "fd --type f";
    # fileWidgetOptions = [ "--preview 'bat --style=plain --theme \'Dracula\' {}'" ];
    # fileWidgetOptions = [ "--preview 'bat --style=plain --theme \'Nord\' {}'" ];
    fileWidgetOptions = [ "--preview 'bat --style=plain --theme \'Catppuccin Mocha\' {}'" ];

    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
