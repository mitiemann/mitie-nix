{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  # Add home-manager to system packages
  environment.systemPackages = with pkgs; [
    home-manager
    sops # secrets manager
    age # actual good encryption
  ];
  
  # Other common system settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/home/mitiemann/.config/sops/age/keys.txt";
  };
}
