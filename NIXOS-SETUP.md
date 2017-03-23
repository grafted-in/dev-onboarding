# Setting Up a NixOS Machine

  1. Download the "Minimal installation CD, 64-bit" from [here](https://nixos.org/nixos/download.html).
  2. Whether you're creating a virtual machine (VM) or setting up your host, you can follow the instructions here to install: https://youtu.be/7B2hSo8ihjI
      * When building a VM:
          * We typically use [VirtualBox](https://www.virtualbox.org/).
          * Use a dynamically sized hard disk and give a lot of space (like 500GB). Resizing the hard disk later is non-trivial so it's worth just making it large at the beginning. NixOS also tends to use a lot of disk space.
  4. Set a few configurations in `/etc/nixos/configuration.nix`:
      * `nix.extraOptions = "auto-optimise-store = true";`
      * Create a non-root user with a password by adding something like this:

            users.users.default = {
              isNormalUser = true;
              home         = "/home/default";
              extraGroups  = ["wheel"];  # Allow this user to act as root.
              password     = "insecure-password";
              # hashedPassword = "some-hash"; # Use this for real security, but you need to know how to use it.
            };

  5. Start optimizing the store: `nix-store --optimize`.
  6. Use this configuration and upgrade by running `sudo nixos-rebuild switch --upgrade`.
  7. Log in as the non-root user (`default` is the name used above).
  8. On a VM:
      * Configure NixOS *System Settings -> Power Management* and disable all energy saving features.
      * (Optional) Clean up garbage and take a snapshot: `nix-collect-garbage -d`
          * **WARNING**: This can be dangerous if your system is not stable. Try rebooting the machine and logging in to make sure things are working with the current profile before destroying your ability to rollback.
