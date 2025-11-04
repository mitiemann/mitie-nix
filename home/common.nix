{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  programs.home-manager.enable = true;
  
  # Your username and home directory
  home.username = "mitiemann";
  home.homeDirectory = "/home/mitiemann";
  home.stateVersion = "25.05";
  
  # Install packages
  home.packages = with pkgs; [
    signal-desktop
    slack
  ];
  
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    
    secrets = {
      email_uni_tuebingen_password = {
        path = "${config.home.homeDirectory}/.config/sops-secrets/email_uni_tuebingen_password";
      };
    };
  };
  
  # Email configuration
  accounts.email.accounts = {
    uni-tuebingen = {
      primary = true;
      address = "michael.tiemann@uni-tuebingen.de";
      userName = "ptioj01";
      realName = "Michael Tiemann";
      
      passwordCommand = "cat ${config.sops.secrets.email_uni_tuebingen_password.path}";
      
      maildir.path = "mail/uni-tuebingen";
      
      imap = {
        host = "mailserv.uni-tuebingen.de";
        port = 993;
        tls.enable = true;
      };
      
      smtp = {
        host = "smtpserv.uni-tuebingen.de";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      
      # Sync mail locally
      mbsync = {
        enable = true;
        create = "maildir";
      };
      
      # Send mail
      msmtp.enable = true;
      
      # Use with aerc
      aerc.enable = true;
    };
  };
  
  # Email programs
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  
  programs.aerc = {
    enable = true;
    extraConfig.general.unsafe-accounts-conf = true;
  };
  
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  
  # Git configuration
  programs.git = {
    enable = true;
    userName = "Michael Tiemann";
    userEmail = "github@michaeltiemann.net";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };
  
}
