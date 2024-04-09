{ config, pkgs, ... }:
{
    users.users.daniel.packages = with pkgs; [
        # apps
        discord spotify steam unstable.obsidian speedcrunch
        # dev tools
        unstable.vscode.fhs nodejs_21 nil
    ];
    fonts.packages = with pkgs; [
    ];
}
