{ config, pkgs, ... }:

{
  # Other common system settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;
  
  # Add home-manager to system packages
  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
