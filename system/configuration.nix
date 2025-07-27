# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true; # DO NOT CHANGE!
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;

  # Early KMS for flicker-free boot with NVIDIA
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # Silent boot for cleaner experience
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];

  networking.hostName = "catharsis"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hsyed = {
    isNormalUser = true;
    description = "Hassan Syed";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Silence dirty git tree warnings for flake commands
  nix.settings.warn-dirty = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    usbutils # meeded for lsusb
    libnotify # for notify-send command
    rtkit # needed for pipewire low latench stuff, not automatically installed
    tailscale
    pkgs.pavucontrol # used as general audio control
    pkgs.pamixer # used for muting
    pkgs.mangohud # gaming stats overlay
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.tailscale.enable = true;

  hardware.graphics = {
    enable = true; # enable opengl I think
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ]; # prime the nvidia driver, the "hardware.nvidia" stuff below doesn't set things up.

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  security.rtkit.enable = true; # makes pipewire go fast (low latench support?)

  services.pipewire = {
    enable = true; # if not already enabled
    pulse.enable = true; # pulse is being superceded by pipewire
    alsa.enable = true; # low level sound functionality -- pipewire talks to this
    alsa.support32Bit = true; # cuz i saw it somewhere
  };

  # game config, see: https://www.youtube.com/watch?v=qlfm3MEbqYA
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true; # wraps a session in a micro compositor for performance reasons
  programs.gamemode.enable = true; # temporarily tunes system for gaming
  # lutris, bottle and heroic not included

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
      initial_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "hsyed";
      };
    };
  };
}
