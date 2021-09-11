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
      "vlcnhil01" = {
        user = "tech";
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target mi-059c7a4e292cde507 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "jpeacock-hitl-001" = {
        user = "jpeacock";
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target mi-08f3572f64c494dac --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "i-* mi-*" = {
        proxyCommand = "sh -c \"aws --profile hitl-devices-administrator ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
    };
  };
}
