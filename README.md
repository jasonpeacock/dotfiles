# Dotfiles

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

Run the bootstrap, which will link any host-specific files and perform other
setup work such as installing Nix and running `home-manager`.

```bash
yadm bootstrap
```
