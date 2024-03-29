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
        mkHost = hostname: username: nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ({ lib, ... }:
                    {
                        options = {
                            hostname = lib.mkOption { type = lib.types.str; };
                            username = lib.mkOption { type = lib.types.str; };
                        };
                        config.hostname = hostname;
                        config.username = username;
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
                ./hosts/${hostname}/configuration.nix
                ./hosts/${hostname}/packages.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                }
            ];
        };
    in {
        nixosConfigurations.xps = mkHost "xps" "daniel";
    };
}
