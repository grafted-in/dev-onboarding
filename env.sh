#!/usr/bin/env bash

NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/$(whoami)/channels/nixpkgs":$NIX_PATH
export NIX_PATH


# == Set up common tools ==

function user-packages() {
  # Common tools
  echo gnugrep
  echo gnumake
  echo wget

  # Security tools
  echo gnupg
  echo keybase
  echo ssh-ident

  # Tools for working with code
  echo git
  echo git-crypt
  echo nix-repl
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

function set-user-config() {
  # Stack can't install its own GHC on NixOS
  stack config set system-ghc --global true

  git config --global gpg.program gpg2
}

function build-user() {
  mkdir -p "$HOME/.nixpkgs"
  user-nix-config > "$HOME/.nixpkgs/config.nix"

  nix-env -f '<nixpkgs>' -iA $(user-packages)

  set-user-config
}
