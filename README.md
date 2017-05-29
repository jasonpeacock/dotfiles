# [Homeshick](https://github.com/andsens/homeshick)

## New Host Setup

Clone, install, and use the dotfiles, including installing & running the git hook!

```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick clone jasonpeacock/dotfiles
homeshick cd dotfiles
cd .git/hooks
ln -s ../../git-hooks/post-merge
cd ../..
.git/hooks/post-merge
homeshick link dotfiles
source $HOME/.zshrc
```

Homeshick by default uses the HTTPS URL for cloning, change to use SSH instead b/c
Github 2FA is enabled and HTTPS won't support pushes:

```
homeshick cd dotfiles
git remote set-url origin git@github.com:jasonpeacock/dotfiles.git
git remote show origin
```

## Host specific configuration

*TBA*

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

## [shellcheck](https://www.shellcheck.net/)

* Install it.


