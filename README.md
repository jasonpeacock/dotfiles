# New Host Setup

## Nix

Install `nix`, which is referenced by the dotfiles and provides all the applications. Use [Determinate System's installer](https://github.com/DeterminateSystems/nix-installer) which makes the install super-easy:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Dotfiles

Dotfiles are managed with Git, using [YADM](https://yadm.io). Once setup, the environment
is then managed using Nix/home-manager to install all the shells, tools, etc.

Install YADM by cloning it - this allows for easy updates:

```bash
git clone https://github.com/TheLocehiliosan/yadm.git ~/.yadm-project

# "Install" to a loation in the default path.
sudo ln -s ~/.yadm-project/yadm /usr/local/bin/yadm
```

Clone the actual dotfiles repo:

```bash
yadm clone git@github.com:jasonpeacock/dotfiles.git
```

Decrypt any secrets.

```bash
yadm decrypt
```

Create host-specific versions of the following files:

```text
~/.config/host-init/<hostname>.fish
~/.config/home-manager/ssh.nix##hostname.<hostname>
~/.config/home-manager/git/host.nix##hostname.<hostname>
```

Run the bootstrap, which will link any host-specific files and perform other
setup work such as installing Nix and running `home-manager`.

```bash
yadm bootstrap
```
