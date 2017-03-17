# Onboarding Procedure for Software Development at Grafted-In

## Your online presence

You need to have or sign up for the following services:

Anything marked with \*\* means that the service is generally useful and you are encouraged to use your own personal email address for the account. But it's up to you.

  1. [LastPass](https://www.lastpass.com/) \*\*
      * You will need to use long, randomized passwords as much as possible so we use a [password manager](https://en.wikipedia.org/wiki/Password_manager) to make this possible. We will also share some passwords with you via this service.
  2. Grafted-In email address
  3. [Keybase](https://keybase.io/) \*\*
      * You may need an invitation to access this. Request one if you don't have it already.
      * Once signed up, please "prove your identity" on as many services as possible.
      * Keybase also has some very neat features if you install their client software on your computer.
  3. [GitHub](https://github.com/) \*\*
      * Many open source projects are hosted by this service and Grafted-In also uses it extensively.
      * As soon as possible, add your PGP public key to your GitHub account to allow for commit verification.
  4. [GitLab](https://gitlab.com/)
      * Grafted-In uses this to host some some projects.
  5. [BitBucket](https://bitbucket.org/) (optional)
      * Grafted-In uses this for some projects, but seldomly. You can leave this one alone for now unless told otherwise.


## Your computer

To simplify development practices we try to all start out with an environment that is almost identical. You may customize your development environment as you become more comfortable with the tools and systems.

  1. You must be using [NixOS](https://nixos.org/) (a unique Linux distribution). If you're on another Linux distribution, let's discuss. If you're on macOS or Windows then:
      1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
      2. Follow the instructions to import the NixOS VirtualBox appliance: https://nixos.org/nixos/download.html
      3. Before booting up the machine, configure the following in Machine Settings:
          1. System -> Motherboad: Give the machine as much memory as you feel comfortable, at least 2GB.
          2. System -> Processor: Give the machine as many processors as you feel comfortable.
      4. Enable bidirectional clipboard (so you can copy/paste between host and VM): Devices -> Shared Clipboard -> Bidirectional.
      5. Log in to this machine (using the `demo` user is fine).
  2. Open a terminal (called Konsole).
  3. Upgrade to latest: `sudo nixos-rebuild switch --upgrade`
  4. Set up your terminal to use your user's channel:
      * `echo export NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/$(whoami)/channels/nixpkgs:$NIX_PATH > ~/.bashrc`
      * `source ~/.bashrc  # to reload your configuration`
  5. Copy the URL to the latest `nixpkgs-unstable` snapshot by going to https://nixos.org/channels/ and copying the URL address for `nixpkgs-unstable`.
  6. Add that URL as your `nixpkgs` channel:
      * `nix-channel --add <URL-you-copied> nixpkgs`
  7. Update:
      * `nix-channel --update`
      * `nix-env --upgrade`

### Getting source code

We'll use [Git](https://git-scm.com/) for [version control](https://en.wikipedia.org/wiki/Version_control).

  1. Install git: `nix-env -f '<nixpkgs>' -iA git`
  2. Authenticate your computer with GitHub:
      1. Create a new SSH key for GitHub:
          * `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github.com -C '<your-name-here>@NixOS-VM on github.com'`
      2. Show your public key: `cat ~/.ssh/id_ed25519_github.com.pub`
      3. Log in to GitHub online and add your new SSH key. Use the output of the previous command to share the key with GitHub.
  3. Repeat the previous process for GitLab, replacing things as necessary.
  4. If you signed up for BitBucket, do the same thing for BitBucket.


### Your editor

Unless you already know a ton about what you're doing, we'll start with [Visual Studio Code](http://code.visualstudio.com/).

  1. Allow restrictive licensed applications to be installed:
      * `mkdir -p ~/.nixpkgs`
      * `echo '{ allowUnfree = true; }' > ~/.nixpkgs/config`
  1. Install the editor: `nix-env -f '<nixpkgs>' -iA vscode`
  2. Open it: `code`
  3. Install the following extensions:
      * `Nix`
      * `Haskell Syntax Highlighting`
      * `haskell-linter`
      * `Haskero`
      * `stylish-haskell`


### Build environment

Install the following tools for working with code:

  1. Install Haskell's [stack](http://haskellstack.org) tool: `nix-env -f '<nixpkgs>' -iA stack`
  2. Install the Nix [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop): `nix-env -f '<nixpkgs>' -iA nix-repl`
