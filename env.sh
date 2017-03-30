#!/usr/bin/env bash

# Based on https://github.com/grafted-in/dev-onboarding/blob/master/env.sh

NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/$(whoami)/channels/nixpkgs":$NIX_PATH
export NIX_PATH


nixpkgs_channel=https://nixos.org/channels/nixpkgs-unstable


function user-packages() {
  # Other packages
  # echo google-chrome
  # echo htop

  # Common tools
  echo curl
  echo gnugrep
  echo gnumake
  echo gzip
  echo less
  echo tree
  echo unzip
  echo wget
  echo xclip
  echo zip

  # Nix tools
  echo nix
  echo nix-prefetch-scripts
  echo nix-repl

  # Security tools
  echo gnupg
  echo keybase
  echo ssh-ident

  # Tools for working with code
  echo git
  echo git-crypt
  echo shellcheck
  echo vim
  echo vscode

  # Haskell-specific tools
  echo ghc
  echo stack
  echo haskellPackages.hlint
  echo haskellPackages.intero
  echo haskellPackages.stylish-haskell

  # VSCode likes to have all dependencies installed from the same channel
  echo bash
  echo coreutils
  echo which
}

function user-nix-config() {
  cat <<'NIX'
{
  allowUnfree = true;
}
NIX
}

function user-apply-app-config() {
  # Stack can't install its own GHC on NixOS
  stack config set system-ghc --global true

  git config --global gpg.program gpg2
}

function user-set-channel() {
  nix-channel --add "$nixpkgs_channel" nixpkgs
}

function user-upgrade-channel() {
  user-set-channel
  nix-channel --update
  nix-env -f '<nixpkgs>' --upgrade
}

function user-build() {
  source "${BASH_SOURCE[0]}" # Be sure to use the most recent version of this file

  # Apply the nixpkgs channel
  user-set-channel

  # Apply nixpkgs config
  mkdir -p "$HOME/.config/nixpkgs"
  user-nix-config > "$HOME/.config/nixpkgs/config.nix"

  # Apply packages
  nix-env -f '<nixpkgs>' --remove-all -iA $(user-packages)

  # Apply various configurations
  user-apply-app-config
}
