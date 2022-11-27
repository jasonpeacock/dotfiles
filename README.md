# [Homeshick](https://github.com/andsens/homeshick)

## New Host Setup

Clone the Homeshick repo, and then retrieve the `dotfile` castle:

```bash
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick clone jasonpeacock/dotfiles
```

Setup git hooks to apply host overrides & secrets:

```bash
homeshick cd dotfiles
cd .git/hooks
mkdir post-merge.d && cd post-merge.d
ln -s ../../../git-hooks/apply-host-overrides 001-apply-host-overrides
ln -s ../../../git-hooks/decrypt-host-secrets 002-decrypt-host-secrets
cd ..
ln -s ../../git-hooks/git-hook-multiplexer post-merge
cd ../..
.git/hooks/post-merge
```

Link all the files & finally source the new environment:

```bash
cd ~
homeshick link dotfiles
source $HOME/.zshrc
```

Homeshick by default uses the HTTPS URL for cloning, change to use SSH instead b/c
Github 2FA is enabled and HTTPS won't support pushes back to the repo:

```bash
homeshick cd dotfiles
git remote set-url origin git@github.com:jasonpeacock/dotfiles.git
git remote show origin
```

## Host specific configuration

### Overrides

Coming soon...

### Secrets

For files that shouldn't be viewable in a public repo, they can be encrypted using the host's SSH key.

```bash
homeshick cd dotfiles
./git-hooks/encrypt-host-secrets /path/to/file path/to/install
mkdir -p home/path/to/install
cd home/path/to/install
ln -s ../../../../secrets/generated/path/to/install/file
git add -A
```

## Applications

### zsh

* Nothing to do, will load plugins & themes on first login.

### [Neovim](https://neovim.io/)

* Run `:CheckHealth` & fix any issues.
* Ensure *git* is using neovim: `git config --global core.editor $(which nvim)`

### [tmux](https://tmux.github.io/)

[Fix tmux on OSX](http://dannykansas.github.io/osx/terminalfu/2015/12/02/fix-open-command-tmux-osx.html):

```bash
brew update
brew install reattach-to-user-namespace
```

* Run `prefix + I` to install plugins.

### [shellcheck](https://www.shellcheck.net/)

* Install it.
