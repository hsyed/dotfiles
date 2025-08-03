# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true; # DO NOT CHANGE!
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 3;
    initrd = {
      systemd.enable = true;
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ]; # Early KMS for flicker-free boot with NVIDIA
      verbose = false;
    };
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  networking = {
    hostName = "catharsis"; # Define your hostname.

    # Enable networking
    networkmanager.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = true;
  };

  services = {
    tailscale.enable = true;

    # use keyd to make the windows layout behave more like a mac.
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];

          settings = {
            main = {
              leftalt = "leftmeta"; # switch alt with meta
              leftmeta = "leftalt";
            };

            "meta:main" = {
              # redirect the keypresses to ctrl to emulate mac bindings
              c = "C-c"; # copy
              x = "C-x"; # cut
              v = "C-v"; # paste
              w = "C-w"; # close tab / window
              t = "C-t"; # open tab
              a = "C-a"; # select all
            };
          };
        };
      };
    };

    openssh = {
      # Enable the OpenSSH daemon.
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
    };

    pipewire = {
      enable = true; # if not already enabled
      pulse.enable = true; # pulse is being superceded by pipewire
      alsa.enable = true; # low level sound functionality -- pipewire talks to this
      alsa.support32Bit = true; # cuz i saw it somewhere
    };

    # greetd is in charge of starting hyprland. The way it is configured no tty are started (at all) and hyoprland is launched directly.
    # no tty with auotologin configured but the first session logs in without asking for credentials.
    greetd = {
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
  };

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
    packages = [ ];
  };

  programs = {
    # nix-ld is used here to enable dynamic linking outside the nix store, this is to support development tooling.
    nix-ld.enable = true;
    # nh is a wrapper for nix management tools for nixos and home-manager. It builds on an intermediate tool (nvd).
    # The main thing we reached for it for is the diff view and an ask step.
    # TODO: nh comes with garbage cleaning functionality that can be wired up with a systemd time, investigate.
    nh.enable = true;
    zsh.enable = true;
  };
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
    pkgs.unzip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  # game config, see: https://www.youtube.com/watch?v=qlfm3MEbqYA
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true; # wraps a session in a micro compositor for performance reasons
  programs.gamemode.enable = true; # temporarily tunes system for gaming
  # lutris, bottle and heroic not included

}
