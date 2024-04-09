{ config, pkgs, ... }:
{
    users.users.daniel.packages = with pkgs; [
        # desktop environment
        unstable.eww rofi-wayland mako lm_sensors upower custom.backlight-rs sway-contrib.grimshot
        # other apps
        discord spotify steam unstable.obsidian speedcrunch
        # dev tools
        unstable.vscode.fhs nodejs_21 nil
    ];
    fonts.packages = with pkgs; [
        custom.material-icons
    ];
}
