# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

# Use the GRUB 2 boot loader.
boot.loader.grub.enable = true;
boot.loader.grub.version = 2;
boot.loader.grub.useOSProber = true;
# boot.loader.grub.efiSupport = true;
# boot.loader.grub.efiInstallAsRemovable = true;
# boot.loader.efi.efiSysMountPoint = "/boot/efi";
# Define on which hard drive you want to install Grub.
boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

networking.hostName = "nixowo"; # Define your hostname.
#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Set your time zone.
time.timeZone = "Europe/London";

# The global useDHCP flag is deprecated, therefore explicitly set to false here.
# Per-interface useDHCP will be mandatory in the future, so this generated config
# replicates the default behaviour.
networking.useDHCP = false;
networking.interfaces.enp0s31f6.useDHCP = true;
networking.interfaces.wlp4s0.useDHCP = true;

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";
console = {
  font = "Lat2-Terminus16";
  keyMap = "us";
};

# Filesystem changes

# Enable the X11 windowing system.
#services.xserver.enable = true;


# Configure keymap in X11
services.xserver.layout = "us";
#services.xserver.xkbOptions = "eurosign:e";

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable sound.
sound.enable = true;
hardware.pulseaudio.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
services.xserver.libinput.enable = true;

# Enable Desktop Environment (Pantheon)
services.xserver.desktopManager.pantheon.enable = true;
#services.xserver.desktopManager.sway.enable = true;
#services.xserver = {


#	displayManager = {
#		defaultSession = "none+awesome";
#	};

#	windowManager.awesome = {
#		enable = true;
#		luaModules = with pkgs.luaPackages; [
#			luarocks # is the package manager for Lua modules
#				luadbi-mysql # Database abstraction layer
#		];

#	};
#};
# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.izzy = {
  isNormalUser = true;
  extraGroups = [ "video" "wheel" "sway" ];
};
users.users.cass = {
  isNormalUser = true;
  extraGroups = [ "wheel" "video" "audio" ]; # Enable ‘sudo’ for the user.
};

# Sway
#wayland.windowManager.sway = {
#	enable = true;
#	wrapperFeatures.gtk = true ;
#};
programs.sway = {
  enable = true;
  wrapperFeatures.gtk = true; # so that gtk works properly
  extraPackages = with pkgs; [
    dmenu-wayland
    swaylock
    swayidle
    wl-clipboard
    mako # notification daemon
    alacritty # Alacritty is the default terminal in the config
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  ];
};
services.xserver = {
  enable = true;


  displayManager = {
    sddm.enable = false;
    defaultSession = "none+awesome";
  };

  windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks # is the package manager for Lua modules
      luadbi-mysql # Database abstraction layer
      luautf8
    ];

  };
};

fonts.fonts = with pkgs; [
  nerdfonts
  noto-fonts
  font-awesome-ttf
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts
  dina-font
  proggyfonts
];

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# Steam
programs.steam.enable = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
#services.nix-autobahn.enable = true;
environment.systemPackages = with pkgs; [
  exa
  compton
  luarocks
  lua
  zip
  pipewire
  unzip
  libreoffice
  transmission
  texlive.combined.scheme-full
  pavucontrol
  discord
  busybox
  polybar
  maim
  xclip
  lxappearance
  brightnessctl
  wget
  alacritty
  mpv
  cmake
  neovim
  neovide
  spotify
  firefox
  chromium
  tor-browser-bundle-bin
  keepassxc
  kleopatra
  sway
  hyper
  starship
  zathura
  ntfs3g
  parted
  gparted
  dunst
  mpd
  rofi
  dmenu
  scrot
  grim
  unclutter
  xsel
  slock
];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
programs.mtr.enable = true;
programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
};

# List services that you want to enable:

# Enable the OpenSSH daemon.
services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ 57621 ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "20.09"; # Did you read the comment?

}

