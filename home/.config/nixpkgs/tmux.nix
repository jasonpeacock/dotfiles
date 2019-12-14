{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    newSession = true;
    secureSocket = false;
    shortcut = "space";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      cpu
      {
        plugin = tmux-colors-solarized;
        extraConfig = "set -g @colors-solarized '256'";
      }
      pain-control
      prefix-highlight
    ];

    extraConfig = "
set -g status-right '#{prefix_highlight} #{cpu_percentage} | %a %h-%d %H:%M '

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

set -g pane-active-border-style fg=yellow
    ";
  };
}
