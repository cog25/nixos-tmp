{ config, pkgs, ... }:

{
    boot.loader.grub = {
    enable = true;
		devices = [ "nodev" ];
		efiSupport = true;
	};
  boot.loader.efi.canTouchEfiVariables = true;

}