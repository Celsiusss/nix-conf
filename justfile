switch:
    sudo nixos-rebuild switch --flake .

update-flake:
    nix flake update

update: update-flake switch
