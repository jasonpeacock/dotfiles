{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;

    compression = true;
    matchBlocks = {
      "jasonpeacock" = {
        hostname = "jasonpeacock.com";
        user = "syzyby";
      };
    };
  };
}
