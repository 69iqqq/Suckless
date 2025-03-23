
{ config, pkgs, inputs, ... }:

{
  programs.anyrun = {
    enable = true;
    config = {
      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        ./some_plugin.so
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/kidex"
      ];
    };

    extraCss = /*css */ ''
      .some_class {
        background: red;
      }
    '';

    extraConfigFiles."some-plugin.ron".text = ''
      Config(
        // for any other plugin
        // this file will be put in ~/.config/anyrun/some-plugin.ron
      )
    '';
  };
}
