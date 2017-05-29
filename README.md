# [Homeshick](https://github.com/andsens/homeshick)

## New Host Setup

Clone, install, and use the dotfiles, including installing & running the git hook!

```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick clone jasonpeacock/dotfiles
source $HOME/.zshrc
```

Homeshick by default uses the HTTPS URL for cloning, change to use SSH instead b/c
Github 2FA is enabled and HTTPS won't support pushes:

```
homeshick cd dotfiles
git remote set-url origin git@github.com:jasonpeacock/dotfiles.git
git remote show origin
```

### Host specific configuration?

Not yet...the git hook works, and it updates the configuration used, but that's also a
change tracked in git - how to avoid accidentally committing it?!

```
homeshick cd dotfiles
cd .git/hooks
ln -s ../../hooks/post-merge
cd ../..
.git/hooks/post-merge
```

## Host Sync

Already configured in the `.zshrc` to check on new shells, but can also be done manually:

```
homeshick refresh
```

# Applications

## zsh

* Nothing to do, will load plugins & themes on first login.

## [Neovim](https://neovim.io/)

* Run `:CheckHealth` & fix any issues.
* Ensure *git* is using neovim: `git config --global core.editor $(which nvim)`

## [tmux](https://tmux.github.io/)

[Fix tmux on OSX](http://dannykansas.github.io/osx/terminalfu/2015/12/02/fix-open-command-tmux-osx.html):

```
brew update
brew install reattach-to-user-namespace
```

* Run `prefix + I` to install plugins.
