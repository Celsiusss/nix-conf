{
    description = "flake?";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };
    outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }:
    let system = "x86_64-linux";
    in {
        nixosConfigurations.nixos-xps = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ({ lib, ... }:
                    {
                        options = {
                            username = lib.mkOption { type = lib.types.str; };
                        };
                        config.username = "daniel";
                    }
                )
                ({
                    nixpkgs.overlays = [
                        (final: prev: {
                            unstable = import nixpkgs-unstable {
                                system = prev.system;
                                config.allowUnfree = true;
                            };
                            custom = import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; };
                        })
                    ];
                 })
                ./configuration.nix
                ./packages.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    # home-manager.users.jdoe = import ./home.nix;

                    # Optionally, use home-manager.extraSpecialArgs to pass
                    # arguments to home.nix

                    home-manager.users.daniel = {
                        programs.git = {
                            enable = true;
                            userName = "Daniel Liland";
                            userEmail = "celsiuss@await.sh";
                        };
                    };
                }

            ];
        };
    };
}
