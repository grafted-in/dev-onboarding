# Setting Up a NixOS Machine

  1. Download the "Minimal installation CD, 64-bit" from [here](https://nixos.org/nixos/download.html).
  2. Whether your creating a virtual machine (VM) or setting up your host, you can follow the instructions here to install: https://youtu.be/7B2hSo8ihjI
      * We use [VirtualBox](https://www.virtualbox.org/) for most things, so for a VM we recommend using it.
  3. Create a non-root user with a password by adding something like this to `/etc/nixos/configuration.nix`:

        ```nix
        users.users.default = {
            isNormalUser = true;
            home         = "/home/default";
            password     = "insecure-password";
            # hashedPassword = "some-hash"; # Use this for real security, but you need to know how to use it.
        };
        ```

        * Use this configuration by running `sudo nixos-rebuild switch`.

  4. Log in as the non-root user (`default` is the name used above).
  5. Set up your terminal to use your user's channel:
      * `echo 'export NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/$(whoami)/channels/nixpkgs:$NIX_PATH' > ~/.bashrc`
