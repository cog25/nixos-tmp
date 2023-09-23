{ config, pkgs, ... }:
{
  networking.hostName = "zenbook"; 

  networking.networkmanager.enable = true;
  
  
  services.tailscale.enable = true;
  networking.nameservers = [ "100.100.100.100" "1.1.1.1" "1.0.0.1" ];
}