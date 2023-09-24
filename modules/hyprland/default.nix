{ config, pkgs, ... }:
{ 
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs;[
    dunst
    hyprpaper
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}