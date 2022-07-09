{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    newSession = true;
    secureSocket = false;
    shortcut = "space";
    terminal = "xterm-256color";
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dracula;
        extraConfig = "
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-show-flags false
          set -g @dracula-show-timezone true
          set -g @dracula-military-time true
          set -g @dracula-border-contrast true
          set -g @dracula-plugins \"cpu-usage time\"
        ";
      }
      pain-control
    ];

    extraConfig = "
# Set ability to capture on start and restore on exit window data when running an application
setw -g alternate-screen on

# Do not show original window name when renaming
bind , command-prompt -p \"(rename-window '#W')\" \"rename-window '%%'\"

# Automatically renumber windows when they move/are closed
set -g renumber-windows on

# Suppress tmux renaming of windows
set -g allow-rename off

# enable the mouse
setw -g mouse on

bind -n WheelUpPane if-shell -F -t = \"#{mouse_any_flag}\" \"send-keys -M\" \"if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'\"
bind -n WheelDownPane select-pane -t= \\; send-keys -M

bind Space last-window

# Allow neovim to change the cursor shape.
set -g -a terminal-overrides ',*:Ss=\\E[%p1%d q:Se=\\E[2 q'

# https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
set -sg escape-time 10

# Override the theme color.
set -g pane-active-border-style fg=green
    ";
  };
}
