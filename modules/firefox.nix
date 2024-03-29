{ ... }:
{
  programs.firefox.enable = true;

  programs.firefox.preferences = {
    "browser.tabs.tabMinWidth" = 0;
  };
  programs.firefox.policies = {
    DisableFirefoxStudies = true;
    DisablePocket = true;
    ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "normal_installed";
      };
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        installation_mode = "normal_installed";
      };
    };
  };
}
