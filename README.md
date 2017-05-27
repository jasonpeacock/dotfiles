# dotfiles

## [Homeshick](https://github.com/andsens/homeshick)

### New Host Setup

```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick clone jasonpeacock/dotfiles
homeshick cd dotfiles
git submodule init && git submodule update
homeshick link dotfiles
source $HOME/.zshrc
```

### Host Sync

Already configured in the `.zshrc` to check on new shells, but can also be done manually:

```
homeshick refresh
```

# Applications

## zsh

* [Antigen](https://github.com/zsh-users/antigen)
* [Powerlevel9k](https://github.com/bhilburn/powerlevel9k)

## [Neovim](https://neovim.io/)

* asdf

## tmux

* [tmux](https://tmux.github.io/)
