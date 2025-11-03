{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  
  # Your username and home directory
  home.username = "mitiemann";
  home.homeDirectory = "/home/mitiemann";
  
  # State version (check what version you're on)
  home.stateVersion = "25.05";
  
  # Install packages
  home.packages = with pkgs; [
    slack
  ];
  
  # Email configuration
  accounts.email.accounts = {
    uni-tuebingen = {
      primary = true;
      address = "michael.tiemann@uni-tuebingen.de";
      userName = "ptioj01";
      realName = "Michael Tiemann";
      
      # Switch to sops-nix later
      passwordCommand = "pass show email/uni-tuebingen";
      
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
    extraConfig.general = {
      unsafe-accounts-conf = true;
    };
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
