{ config, pkgs, ... }:

{

  imports = [
    ./modules/hyprland/home.nix
  ];


  home.username = "cog25";
  home.homeDirectory = "/home/cog25";

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # basic configuration of git, please change to your own

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    ranger
    gh

    # archives
    zip
    unzip

    fzf # A command-line fuzzy finder

    # networking tools
    aria2
    
    # misc
    cowsay
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  programs.git = {
    enable = true;
    userName = "cog25";
    # keep-my-email-secret
    userEmail = "74242561+cog25@users.noreply.github.com";
  };
  
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your cusotm bashrc here

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      vi = "nvim";

      ssh-elaina = "ssh cog25@elaina";
    };
  };



  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
