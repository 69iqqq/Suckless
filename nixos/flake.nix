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
