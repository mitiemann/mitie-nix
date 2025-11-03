{ config, pkgs, ... }:

{
  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  
  # Your username and home directory
  home.username = "mitiemann";
  home.homeDirectory = "/home/mitiemann";
  
  # State version (check what version you're on)
  home.stateVersion = "25.05";  # Adjust to your NixOS version
  
  # Install Slack
  home.packages = with pkgs; [
    slack
  ];
}
