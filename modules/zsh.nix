{ config, pkgs, ... }:
{
  programs.zsh.enable = true;
  home-manager.users.${config.username} = { ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        custom = "${pkgs.custom.omz-custom}";
        theme = "gianu-custom";
        plugins = ["git"];
      };
    };
  };

}
