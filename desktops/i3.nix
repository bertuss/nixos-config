# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#
# ?? https://github.com/disassembler/nixos-configurations/blob/master/modules/profiles/i3.nix

{ config, pkgs, ... }:

{

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  
  services.xserver.desktopManager = {xterm.enable=false;};
  services.displayManager.defaultSession = "none+i3";
    
  services.xserver.windowManager.i3 = {
    enable = true;
    extraSessionCommands = ''
        ${pkgs.dunst}/bin/dunst &
      '';
    extraPackages = with pkgs; [
      dmenu 
      autorandr
      autotiling
      i3status
      i3lock
      acpi
      rofi
      rofi-pass
      st
      xterm
      polybar
      (python3Packages.py3status.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = with python3Packages; [ pytz tzlocal ] ++ oldAttrs.propagatedBuildInputs;
      }))
    ];
  };

  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };

}
