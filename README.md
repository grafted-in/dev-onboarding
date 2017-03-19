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

  1. You must be using [NixOS](https://nixos.org/) (a unique Linux distribution). If you're on another Linux distribution, let's discuss. If you want to set this up yourself (either as a virtual machine or on your host) then refer to `NIXOS-SETUP.md`. However, for most people, just start with a virtual machine (VM) and use Grafted-In's base pre-built image:
      1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
      2. Download the Grafted-In base NixOS virtual machine (this will be provided separately). Put the folder in a place that won't change.
      3. Tell VirtualBox about your machine by opening VirtualBox and selecting *Machine -> Add...* and finding your machine.
      4. Before booting up the machine, configure the following in *Machine -> Settings*:
          1. *System -> Motherboad*: Give the machine as much memory as you feel comfortable, at least 2GB.
          2. *System -> Processor*: Give the machine as many processors as you feel comfortable.
          3. **Use VirtualBox to take a snapshot of the machine before you make any changes.** This will make it much easier to undo bad choices. We recommend that you take snapshots before doing any major changes to your system. (In VirtualBox you can take a snapshot by clicking on your machine and selecting the *Snapshots* tab next to the *Details* tab.)
      5. Enable bidirectional clipboard (so you can copy/paste between host and VM): *Devices -> Shared Clipboard -> Bidirectional*.
      6. Log in to this machine (credentials will be provided separately).
  2. Open a terminal.
      * **NOTE:** In the NixOS terminal copy has the shortcut `Ctrl+Shift+C` and paste has the shortcut `Ctrl+Shift-V`. These are different than normal and it's easy to get confused! You can also use the right-click menu to copy/paste or look up the shortcuts again.
  3. Upgrade to latest: `sudo nixos-rebuild switch --upgrade`
  4. Set `nixpkgs-unstable` as your package channel:
      * `nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs`
  5. Update:
      * `nix-channel --update`
      * `nix-env --upgrade`


### Build environment

Install the following tools for working with code:

  1. Install the Nix [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop): `nix-env -f '<nixpkgs>' -iA nix-repl`
  2. Install Haskell's [stack](http://haskellstack.org) tool: `nix-env -f '<nixpkgs>' -iA stack`
  3. Install [Intero](https://hackage.haskell.org/package/intero) for editor support: `nix-env -f '<nixpkgs>' -iA haskellPackages.intero`
  4. Install [HLint](http://community.haskell.org/~ndm/darcs/hlint/hlint.htm) for getting hints on how to improve your code: `nix-env -f '<nixpkgs>' -iA haskellPackages.hlint`
  5. Install [Stylish Haskell](https://github.com/jaspervdj/stylish-haskell/blob/master/README.markdown) for help formatting your code: `nix-env -f '<nixpkgs>' -iA haskellPackages.stylish-haskell`


### Your editor

Unless you already know a ton about what you're doing, we'll start with [Visual Studio Code](http://code.visualstudio.com/).

  1. Allow restrictive licensed applications to be installed:
      * `mkdir -p ~/.nixpkgs`
      * `echo '{ allowUnfree = true; }' > ~/.nixpkgs/config`
  1. Install the editor: `nix-env -f '<nixpkgs>' -iA vscode`
  2. Open it: `code`
  3. Install the following extensions (these depend on some the tools you installed in **Build environment** above):
      * `Nix`
      * `Haskell Syntax Highlighting`
      * `haskell-linter` (needs `hlint`)
      * `Haskero` (needs `stack` and `intero`)
      * `stylish-haskell` (needs `stylish-haskell`)


### Getting source code

We'll use [Git](https://git-scm.com/) for [version control](https://en.wikipedia.org/wiki/Version_control).

  1. Install git: `nix-env -f '<nixpkgs>' -iA git`
  2. Authenticate your computer with GitHub:
      1. Create a new SSH key for GitHub:
          * `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github.com -C 'default@NixOS-VM on github.com'`
      2. Show your public key: `cat ~/.ssh/id_ed25519_github.com.pub`
      3. Log in to GitHub online and add your new SSH key. Use the output of the previous command to share the key with GitHub.
  3. Repeat the previous process for GitLab, replacing things as necessary.
  4. If you signed up for BitBucket, do the same thing for BitBucket.


### Security & PGP

We take security very seriously and make heavy use of [PGP](https://en.wikipedia.org/wiki/Pretty_Good_Privacy). The most common tool for using PGP is [GnuPGP](https://www.gnupg.org/), or GPG for short. PGP with GPG - it gets annoying.

We also use [Keybase](https://keybase.io/) for managing PGP identities. If you haven't signed up for that, do so now.

  1. Install GPG: `nix-env -f '<nixpkgs>' -iA gnupg`
  2. Install the Keybase client: `nix-env -f '<nixpkgs>' -iA keybase`
  3. Log in to the Keybase client: `keybase login`
  4. Import your Keybase identity into GPG:
      * `keybase pgp export --secret | gpg --allow-secret-key-import --import`
      * ([referencehere](https://iwader.co.uk/post/signing-git-commits-keybase-gpg-key))
  5. Install [git-crypt](https://www.agwa.name/projects/git-crypt/) for working with secret files: `nix-env -f '<nixpkgs>' -iA git-crypt`
