{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/i18n.nix
      ./modules/network.nix
      ./modules/bootloader.nix
      ./modules/virt.nix
      ./modules/hyprland
    ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  users.users.cog25 = {
    isNormalUser = true;
    description = "cog25";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    # packages = with pkgs; []; # Check `home.nix`
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # CLI
    neovim
    wget
    coreutils-full
    xdg-utils

    git

    # GUI
    alacritty
    wofi
    firefox
    vscode
    tailscale
    obs-studio
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };



  system.stateVersion = "23.05"; 

}
