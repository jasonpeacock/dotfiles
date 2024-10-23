{pkgs, ...}: {
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      format = pkgs.lib.concatStrings [
        "$\{custom.hostname\}"
        "$time$cmd_duration$fill"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$aws"
        "$env_var"
        "$custom"
        "$sudo"
        "$line_break"
        "$jobs"
        "$battery"
        "$status"
        "$shell"
        "$character"
      ];
      fill = {
        symbol = " ";
      };
      character = {
        success_symbol = "[➜](bold blue)";
        error_symbol = "[✗](bold red)";
      };
      cmd_duration = {
        min_time = 1000;
        format = "- [$duration]($style)";
        style = "bold cyan";
      };
      custom = {
        hostname = {
          command = "echo $HOST_NICKNAME";
          when = true;
          format = "[$output]($style) - ";
          style = "bold blue";
        };
      };
      directory = {
        read_only = " ";
        truncation_length = 3;
        truncate_to_repo = false;
        truncation_symbol = ".../";
        style = "bold blue";
      };
      aws = {
        symbol = " ";
        style = "bold #ffb86c";
      };
      docker_context = {
        symbol = " ";
        disabled = true;
      };
      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        truncation_length = 30;
        style = "bold cyan";
      };
      git_commit = {
        commit_hash_length = 8;
      };
      git_metrics = {
        disabled = false;
      };
      git_status = {
        ahead = "⇡$\{count\}";
        diverged = "⇕⇡$\{ahead_count\}⇣$\{behind_count\}";
        behind = "⇣$\{count\}";
        style = "bold cyan";
      };
      golang = {
        symbol = " ";
        disabled = true;
      };
      hostname = {
        style = "bold cyan";
        disabled = true;
      };
      java = {
        symbol = " ";
        disabled = true;
      };
      memory_usage = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
        disabled = true;
      };
      nodejs = {
        symbol = " ";
        disabled = true;
      };
      package = {
        symbol = " ";
        disabled = true;
      };
      perl = {
        symbol = " ";
        disabled = true;
      };
      python = {
        symbol = " ";
        disabled = true;
      };
      ruby = {
        symbol = " ";
        disabled = true;
      };
      rust = {
        symbol = " ";
        disabled = true;
      };
      time = {
        format = "[$time]($style) ";
        time_format = "%F %R";
        disabled = false;
        style = "bold cyan";
      };
      username = {
        format = "[$user]($style) on ";
        style_user = "bold cyan";
        disabled = true;
      };
    };
  };
}
