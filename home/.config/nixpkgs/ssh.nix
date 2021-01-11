{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
    forwardAgent = true;

    extraOptionOverrides = {
      "IgnoreUnknown" = "GSSAPIKeyExchange";
    };

    extraConfig = "
GSSAPIKeyExchange yes
GSSAPIAuthentication yes
GSSAPIDelegateCredentials yes
    ";

    compression = true;
    matchBlocks = {
      "bloggg" = {
        hostname = "35.167.77.210";
        user = "ec2-user";
        identityFile = "~/.ssh/LightsailDefaultKey-us-west-2.pem";
      };
      "jasonpeacock" = {
        hostname = "jasonpeacock.com";
        user = "syzyby";
      };
      "cloud" = {
        #hostname = "dev-dsk-jpeacock-2c-601aaa4a.us-west-2.amazon.com";
        hostname = "jpeacock-cloud.aka.corp.amazon.com";
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
