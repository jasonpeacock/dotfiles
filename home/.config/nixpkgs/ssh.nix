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
      "bus-hitl-dut-rpi-jpeacock" = {
        user = "pi";
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target mi-00fd9556945d67d6a --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "bus-hitl-tm-jpeacock" = {
        user = "jpeacock";
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target mi-08cf94e4ed22949f0 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "bus-hitl-tm-001" = {
        user = "jpeacock";
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target mi-0cf7d7a416ff64119 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "bus-hitl-tm-002" = {
        user = "jpeacock";
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target mi-0aea38929e597ecca --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "i-* mi-*" = {
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
    };
  };
}
