## Environment variables configuration
#
# LANG
#
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# EDITOR
#
export EDITOR='vim'
export PAGER='less'
export LESSEDIT='vi %f'
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'

# PATH
#
case ${OSTYPE} in
    darwin*)
        export PATH='/usr/local/bin:/usr/bin:/opt/local/bin:/opt/local/sbin:/sw/bin:/sw/sbin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin'
        export MANPATH='/opt/local/share/man:/usr/share/man:/usr/local/share/man:/usr/X11/man'
        ;;
    *)
        export PATH='/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin'
        export MANPATH='/usr/share/man:/usr/local/share/man:~/share/man:~/man'
        export PATH=~/bin:$PATH
        export MANPATH=~/share/man:~/man:$MANPATH
        export LD_LIBRARY_PATH=~/lib:~/lib64:/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:$LD_LIBRARY_PATH
        export C_INCLUDE_PATH=~/include:/usr/local/include:/usr/include:$C_INCLUDE_PATH
        ;;
esac

# Additional PATH
#
export TEX_BIN=/Library/TeX/Root/bin/x86_64-darwin 
export GRADLE_HOME=/opt/local/share/java/gradle
export VIM_HOME=~/.vim
export PYTHONSTARTUP=~/.pythonstartup

export PATH=$PATH:$VIM_HOME/bin:$TEX_BIN

# CLASSPATH
export CLOJURE_EXT=/opt/local/share/java/clojure
export VIMCLOJURE_HOME=/opt/local/share/vimclojure

export CLASSPATH=$CLOJURE_EXT/lib/clojure.jar:$CLOJURE_EXT/lib/clojure-contrib.jar:$VIMCLOJURE_HOME/build/libs/vimclojure.jar:$VIMCLOJURE_HOME/server/build/libs/server-2.3.2-SNAPSHOT.jar

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
    0)
        PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
    *)
        PROMPT="%{${fg[yellow]}%}%/%%%{${reset_color}%} "
        PROMPT2="%{${fg[yellow]}%}%_%%%{${reset_color}%} "
        SPROMPT="%{${fg[yellow]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
esac

# auto change directory
#
setopt auto_cd

# auto push directory
#
setopt auto_pushd
setopt pushd_ignore_dups

# use #, ~, ^ as regexp in filename
#
setopt extended_glob

# expand {a-c} to a b c
#
setopt brace_ccl

# auto fill braket
#
setopt auto_param_keys

# when complement a directory name auto append /
#
# setopt auto_param_slash

# when expand filename append / if it's a directory
#
setopt mark_dirs

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# when exec same name as suspended process, resume it
setopt auto_resume

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
bindkey -e
# bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt extended_history     # write time when login/logout to history file


## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

## zsh editor
#
autoload zed

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"
setopt long_list_jobs

case "${OSTYPE}" in
    *bsd*|darwin*)
        alias ls="ls -GFh"
        ;;
    linux*)
        alias ls="ls --color=auto -Fh"
        ;;
esac

alias la="ls -A"
alias ll="ls -l"

alias h=history
alias grep="egrep --color=auto"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias stop="kill -TSTP"

alias .G="git --work-tree=$HOME/ --git-dir=$HOME/dotfiles.git"

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
    xterm*|screen*)
        case "${OSTYPE}" in
            linux*|darwin*)
                export TERM=linux
                ;;
            *)
                export TERM=xterm-color
                ;;
        esac
        ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm*|linux)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        export LSCOLORS=gxfxcxdxbxegedabagacad
        export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
esac
