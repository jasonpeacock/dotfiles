# .zshrc
#
# .zshenv  : first
# .zprofile: second, only if it's a login shell
# .zshrc   : third if it's an interactive shell
# .zlogin  : fourth if it's a login shell
# .zlogout : when the shell exits

#
# Dotfile management with homeshick.
#
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
# Check everything is up-to-date.
homeshick --quiet refresh

#
# Customize the Powerlevel9k theme.
# https://github.com/bhilburn/powerlevel9k
#
# This must be set before the theme is used by antigen.
#
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context_joined)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(dir vcs command_execution_time)
# Default 'context' is "%n@%m", drop the username (%n) and always show it.
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_TEMPLATE="%m"
# Shorten the 'dir'.
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER=".."
# Drop the return code from 'status' and always show it.
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
# Use the awesome version of SourceCodePro font.
#POWERLEVEL9K_MODE='awesome-patched'
# Remove the extraneous Git icons (it's always Git).
POWERLEVEL9K_VCS_GIT_ICON=""
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=""
# Remove the duration icon, keep things compact.
POWERLEVEL9K_EXECUTION_TIME_ICON=""
# Remove the folder icons, keep things compact.
POWERLEVEL9K_FOLDER_ICON=""
POWERLEVEL9K_HOME_ICON=""
POWERLEVEL9K_HOME_SUB_ICON=""

#
# Customize zsh-autosuggestion
#
# 10 = dark grey
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

#
# ZSH configuration with Antigen.
#
source $HOME/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle python
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

if [[ $CURRENT_OS == 'OS X' ]]; then
	antigen bundle brew
	antigen bundle brew-cask
	antigen bundle osx
elif [[ $CURRENT_OS == 'Linux' ]]; then
fi

antigen theme bhilburn/powerlevel9k

antigen apply

#
# Load host-specific configuration.
#
THIS_BOX=`hostname | sed 's/\..*$//'`
if [ -f $HOME/.zsh/$THIS_BOX.zshrc ] ; then
	. $HOME/.zsh/$THIS_BOX.zshrc
else
	echo "*** No host-specific file found! Expected: \"$HOME/.zsh/$THIS_BOX.zshrc\" ***"
fi

# Add local apps to the path.
export PATH="$PATH:$HOME/bin"

#
# Aliases.
#
alias bc='bc -l -q $HOME/.bc'
alias checkpoint='git status && git add -A && git commit -m "checkpoint" --no-verify'
alias grep='grep --color=auto'
alias less='less -R -n'
alias scp='/usr/bin/scp -C'
alias tbase='tmux attach -t base || tmux new -s base'
alias vi='nvim -o'
alias work='cd $HOME/workplace'
alias http='python3 -m http.server'

#
# Jump Marks
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
#
export MARKPATH=$HOME/.marks

function jump {
	cd -P "$MARKPATH/$1" 2>/dev/null && cd `echo $PWD | sed 's/\/rhel5pdi//'` || echo "No such mark: $1"
}

function mark {
	mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
	rm -i "$MARKPATH/$1"
}

function marks {
	ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function _completemarks {
	reply=($(ls $MARKPATH))
}

compctl -K _completemarks jump
compctl -K _completemarks unmark

