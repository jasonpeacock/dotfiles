# .zshrc
#
# .zshenv  : first
# .zprofile: second, only if it's a login shell
# .zshrc   : third if it's an interactive shell
# .zlogin  : fourth if it's a login shell
# .zlogout : when the shell exits

#################### dotfile management with homeshick #######
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# check that everything is fresh
homeshick --quiet refresh

#################### oh-my-zsh (future) ######################
# source $ZSH/oh-my-zsh.sh

#################### coloring matters ########################
# Color codes: 00;{30,31,32,33,34,35,36,37} and 01;{30,31,32,33,34,35,36,37}
# are actually just color palette items (1-16 in gnome-terminal profile)
# your pallette might be very different from color names given at (http://man.he.net/man1/ls)
# The same LS_COLORS is used for auto-completion via zstyle setting (in this file)
#
LS_COLORS_BOLD='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.tex=01;33:*.sxw=01;33:*.sxc=01;33:*.lyx=01;33:*.pdf=0;35:*.ps=00;36:*.asm=1;33:*.S=0;33:*.s=0;33:*.h=0;31:*.c=0;35:*.cxx=0;35:*.cc=0;35:*.C=0;35:*.o=1;30:*.am=1;33:*.py=0;34:'
LS_COLORS_NORM='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.ogg=00;35:*.mp3=00;35:*.wav=00;35:*.tex=00;33:*.sxw=00;33:*.sxc=00;33:*.lyx=00;33:*.pdf=0;35:*.ps=00;36:*.asm=0;33:*.S=0;33:*.s=0;33:*.h=0;31:*.c=0;35:*.cxx=0;35:*.cc=0;35:*.C=0;35:*.o=0;30:*.am=0;33:*.py=0;34:'
MY_LS_COLORS=${MY_LS_COLORS:-LS_COLORS_BOLD}
eval export LS_COLORS=\${$MY_LS_COLORS}

typeset -ga precmd_functions
typeset -ga preexec_functions

######################################
# load host-specific stuff
THIS_BOX=`hostname | sed 's/\..*$//'`
if [ -f $HOME/.zsh/$THIS_BOX.zshrc ] ; then
        . $HOME/.zsh/$THIS_BOX.zshrc
    else
        echo "*** No host-specific file found! Expected: \"$HOME/.zsh/$THIS_BOX.zshrc\" ***"
fi

autoload -U colors && colors

#
# PATH
#
export PATH="$PATH:$HOME/bin"

######################### zsh options ################################
setopt ALWAYS_TO_END           # Push that cursor on completions.
setopt AUTO_NAME_DIRS          # change directories to variable names
setopt NO_BEEP                 # self explanatory

######################### history options ############################
setopt EXTENDED_HISTORY        # store time in history
setopt HIST_EXPIRE_DUPS_FIRST  # unique events are more usefull to me
setopt HIST_VERIFY             # Make those history commands nice
setopt INC_APPEND_HISTORY      # immediatly insert history into history file
setopt SHARE_HISTORY           # share history immediately between terminals
HISTSIZE=16000                 # spots for duplicates/uniques
SAVEHIST=15000                 # unique events guarenteed
HISTFILE=~/.history
setopt histignoredups          # ignore duplicates of the previous event

export GREP_COLOR=${GREP_COLOR:-1;35}    # Set the color for grep matches
export TERM=xterm-256color     # support solarized/tmux colors
export PAGER=less              # less is more
export EDITOR=nvim             # Neovim is the future
export VISUAL=$EDITOR          # some programs use this instead of EDITOR

# VI editing mode is a pain to use if you have to wait for <ESC> to register.
# This times out multi-char key combos as fast as possible. (1/100th of a
# second.)
KEYTIMEOUT=1

# allow scripts called by this shell to detect an improved env:
export ENV_IMPROVEMENT_ENABLED=1

# If a command takes >10 CPU seconds, automatically print the time it took.
export REPORTTIME=10
# Format the output of the time command to be a little more human friendly.
export TIMEFMT=" Elapsed: %*E User: %U Kernel: %*S"

# shell keybindings are emacs, b/c that's what my fingers know
bindkey -e
bindkey "^R" history-incremental-search-backward
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line

#AWESOME...
#pushes current command on command stack and gives blank line, after that line
#runs command stack is popped
bindkey "^T" push-line-or-edit

######################### completion #################################
# these are some (mostly) sane defaults, if you want your own settings, I
# recommend using compinstall to choose them.  See 'man zshcompsys' for more
# info about this stuff.

setopt extended_glob

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true

if [[ $IGNORE_APOLLO_1 != 'NO' ]]
then
  # Ignore /apollo_1 for directories.  That dir is an import directory
  zstyle ':completion:*' ignored-patterns '/apollo_1'
fi

autoload zmv
alias 'zcp=noglob zmv -W -C'
alias 'zln=noglob zmv -W -L'
alias 'zmv=noglob zmv -W -M'

autoload -U compinit
compinit
# End of lines added by compinstall

# custom prompt, also updates terminal title w/current dir
function precmd {
        # setup warning if we're in a Vim shell
        VIM_WARN=""
        if [ ${VIMRUNTIME} ]; then
            VIM_WARN="--VIM-- "
        fi
        # update terminal title
        print -Pn "\e]0;%m: %d\a"
        # update prompt
        export PROMPT="%(?,%{$fg_bold[green]%}%B:%)%b,%{$fg_bold[red]%}%B:(%b) %B${VIM_WARN}%b$(print '%30<...<%//%{\e[0m%} ')"
}

#
# aliases
#
alias bc='bc -l -q $HOME/.bc'
alias checkpoint='git status && git add -A && git commit -m "checkpoint"'
alias grep='grep --color=auto'
alias less='less -R -n'
alias scp='/usr/bin/scp -C'
alias tbase='tmux attach -t base || tmux new -s base'
alias vi='nvim -o'
alias work='cd $HOME/workplace'
alias http='python3 -m http.server'

##########
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
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
#
##########

