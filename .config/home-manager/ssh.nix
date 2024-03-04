{pkgs, ...}: {
  programs.ssh = {
    enable = true;

    compression = true;
    forwardAgent = true;
    serverAliveInterval = 15;
    serverAliveCountMax = 44;

    extraOptionOverrides = {
      "IgnoreUnknown" = "GSSAPIKeyExchange";
    };

    extraConfig = "
Match all
CheckHostIP no
TCPKeepAlive yes
IPQoS=throughput
GSSAPIKeyExchange no
GSSAPIAuthentication no
GSSAPIDelegateCredentials no
    ";

    matchBlocks = {
      "dev-dsk-*.amazon.com" = {
        proxyCommand = "/usr/local/bin/wssh proxy %h";
      };
      "*.corp.amazon.com" = {
        proxyCommand = "/usr/local/bin/wssh proxy %h";
      };
      "git.amazon.com" = {
        proxyCommand = "/usr/local/bin/wssh proxy %h";
      };
      "cloud" = {
        proxyCommand = "/usr/local/bin/wssh proxy %h";
        #hostname = "dev-dsk-jpeacock-2c-601aaa4a.us-west-2.amazon.com";
        hostname = "jpeacock-cloud.aka.corp.amazon.com";
        remoteForwards = [
          {
            bind.port = 2224;
            host.address = "127.0.0.1";
            host.port = 2224;
          }
          {
            bind.port = 8000;
            host.address = "127.0.0.1";
            host.port = 15080;
          }
        ];
      };
      "i-* mi-*" = {
        proxyCommand = "sh -c \"aws --profile flatsat ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
      "bloggg" = {
        hostname = "35.167.77.210";
        user = "ec2-user";
        identityFile = "~/.ssh/LightsailDefaultKeyPair-us-west-2.pem";
      };
      "jasonpeacock" = {
        hostname = "jasonpeacock.com";
        user = "syzyby";
      };
    };
  };
}
