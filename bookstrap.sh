# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# source nix
. /nix/var/nix/profiles/default/etc/profile.d/nix.sh

# test nix
nix-shell -p nix-info --run "nix-info -m"

alias nx='nix--extra-experimental-features "nix-command flakes" '
