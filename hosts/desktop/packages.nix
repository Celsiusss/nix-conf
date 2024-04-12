{ config, pkgs, ... }:
{
    users.users.daniel.packages = with pkgs; [
        # apps
        discord spotify steam speedcrunch
        prismlauncher gimp
        # dev tools
        unstable.vscode.fhs nodejs_21 nil
        nvtop-amd
    ];
    fonts.packages = with pkgs; [
    ];
}
