{ pkgs, ... }:

{
  programs.git-cliff = {
    enable = true;
    # https://docs.atuin.sh/configuration/config/
    settings = {
        sort_commits = "newest";
        conventional_commits = true;
        filter_unconventional = false;
        commit_parsers = [
            "{ message = \".*\", group = \"Other\", default_scope = \"other\" }"
        ];
    };
  };
}
