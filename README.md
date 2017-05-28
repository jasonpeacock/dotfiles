# [Homeshick](https://github.com/andsens/homeshick)

## New Host Setup

```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick clone jasonpeacock/dotfiles
source $HOME/.zshrc
```

If the git submodules didn't update, update them manually:

```
homeshick cd dotfiles
git submodule init && git submodule update
homeshick link dotfiles
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
