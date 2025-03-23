{
  description = "One flake to rule them all";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    marble = {
      url = "git+ssh://git@github.com/marble-shell/shell?ref=gtk4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    icon-browser = {
      url = "github:aylur/icon-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    battery-notifier = {
      url = "github:aylur/battery-notifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    morewaita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  # 🛠 Fix: Ensure `inputs` is passed to `outputs`
  outputs = { self, nixpkgs, home-manager, hyprland, hyprland-plugins, ... }@inputs: 
  {
    nixosConfigurations = {
      abir = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };

    homeConfigurations = {
      abir = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs; }; # ✅ Now inputs is correctly passed
      };
    };
  };
}
