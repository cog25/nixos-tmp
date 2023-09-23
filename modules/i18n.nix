{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Seoul";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "kime";
      kime = {
        iconColor = "White";
      };
    };
  };
  
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pretendard
      noto-fonts-cjk-serif
      jetbrains-mono
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif CJK KR" ];
      sansSerif = [ "Pretendard" ];
      monospace = [ "Jetbrains Mono" ];
    };
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    layout = "kr";
    xkbVariant = "kr104";
  };

}
