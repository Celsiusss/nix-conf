{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        vim git wget zsh gparted jq bc gcc
    ];
    users.users.daniel.packages = with pkgs; [
        # essential
        firefox kate alacritty thunderbird
        # desktop environment
        unstable.eww rofi-wayland mako lm_sensors upower custom.backlight-rs
        # other apps
        discord spotify steam unstable.obsidian
        # dev tools
        unstable.vscode.fhs nodejs_21 nil
        # utils
        htop btop
    ];
    fonts.packages = with pkgs; [
        custom.material-icons
    ];
}
