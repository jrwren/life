# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
HISTCONTROL=ignoreboth
HISTSIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# error on use of unset variable
set -u

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    if [ ! -z "`which dircolors`" ]; then
        eval `dircolors -b`
        alias ls='ls --color=auto'
    else
        alias ls='ls -G'
    fi
    #alias rt='ionice -c 3 rtorrent -O 'schedule=watchdir,0,1,load_start=*.torrent' -- `ls -rtQ *.torrent`'
    alias rt="rtorrent -O 'schedule=watchdir,0,1,load.start_verbose=*.torrent'"
    # `tmux new-session -t 1` to create a new session attached to session 1
    # `tmux list-sessions` to liste the sessions
    alias tmuxa='tmux attach-session -t 0'
    alias phpman='man -M ~/pear/docs/pman'
	#alias less='less -r'
	# set PATH so it includes user's private bin if it exists
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi
if [[ -d $HOME/bin ]] && ! echo $PATH | grep -q $HOME/bin ; then
    PATH=$HOME/bin:"${PATH}"
fi
if [[ ! -v DISPLAY ]];then
    alias vi='vim -X'
    alias vim='vim -X'
fi
[[ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && alias vim=/Applications/MacVim.app/Contents/MacOS/Vim && alias vi=vim && alias mvim=/Applications/MacVim.app/Contents/bin/mvim

if [[ -v HOSTNAME ]]; then HOSTNAME=`hostname`;fi
if [[ `hostname -s` == "gogogogogogogo" ]]; then HOSTNAME='gogo'; fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in
#if [[ -v debian_chroot && -r /etc/debian_chroot ]]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi
[[ ! -v debian_chroot ]] && debian_chroot=""
[[ ! -v WINDOW ]] && WINDOW=""
[[ ! -v TMUX_PAIN ]] && TMUX_PAIN=""

# A color and a non-color prompt:
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
PS1='${debian_chroot:+($debian_chroot)}\e[1;31m[${PWD}:${WINDOW}${TMUX_PAIN}]\e[1;32m[\A]\e[m\e[1;36m\n[\u@\h:\$]\e[m '
if [[ -v ITERM_PROFILE && "$ITERM_PROFILE" == "Default Light" ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\D{%d%m%y-%H%M%S}\[\033[01;31m\]jrw@${HOSTNAME}\[\033[00m\]:{${WINDOW}${TMUX_PANE}}\[\033[01;34m\]\w\[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\D{%y%m%d-%H%M%S}\[\033[01;32m\]jrw@${HOSTNAME}\[\033[00m\]:{${WINDOW}${TMUX_PANE}}\[\033[01;34m\]\w\[\033[00m\]'
fi

function sshauthsock () {
#export SSH_AUTH_SOCK=$(lsof  -b  -a -p $(ps x | grep ssh-agen[t] | awk '{print $1}')  -a -U 2>/dev/null | awk '/3u/{print $8}')
SSH_AUTH_SOCK=`find /tmp/ssh*  -type s -printf "%p\n" | head -1`
}
alias ssh-agent-refresh=sshauthsock

[[ -d $HOME/tmp ]] && export TMPDIR=$HOME/tmp
: ${TMPDIR:=/tmp}

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen*)
    if [[ ! -z "`find --version 2>/dev/null | grep GNU`" ]];then
        UNAME=$(uname)
        if [[ "$UNAME" == "Linux" ]]; then
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}:${WINDOW}\007";'
            SSH_OAUTH_SOCK=$SSH_AUTH_SOCK
#            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}:${WINDOW}\007";[[ -z "$SSH_AUTH_SOCK" || ! -s "$SSH_AUTH_SOCK" ]] && export SSH_AUTH_SOCK=`find /tmp/ssh* $TMPDIR/ssh*  -type s 2>/dev/null | head -1 | cut -f 2 -d " "`'
        fi
        if [[ "$UNAME" == "Darwin" ]]; then
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}:${WINDOW}\007";'
        fi
    else
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@$HOSTNAME:${PWD}:${WINDOW}\007"'
    fi
    ;;
*)
    ;;
esac

set +u
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

if [[ -r /etc/debian_version ]]; then
export DEBFULLNAME="Jay R. Wren"
export DEBEMAIL="jrwren@xmtp.net"
fi

export EMAIL="jrwren@xmtp.net"

export EDITOR=vim

if [[ -x /usr/bin/cdrecord ]]; then
export CDR_SPEED=16
fi

#pip completion, kinda cool
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip

#fab completion, cool still
_fab_completion() {
    COMPREPLY=( $( \
    COMP_LINE=$COMP_LINE  COMP_POINT=$COMP_POINT \
    COMP_WORDS="${COMP_WORDS[*]}"  COMP_CWORD=$COMP_CWORD \
    OPTPARSE_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _fab_completion fab

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose svn"
if [[ -r ~/.git-completion.bash ]]; then
    source ~/.git-completion.bash
fi
if [[ -r /usr/local/git/contrib/completion/git-completion.bash ]]; then
    source /usr/local/git/contrib/completion/git-completion.bash
fi
XCODE_DEV_TOOLS=/Applications/Xcode.app/Contents/Developer/usr/share/git-core
[[ -r $XCODE_DEV_TOOLS/git_completion.bash ]] && source $XCODE_DEV_TOOLS/git_completion.bash
[[ -r $XCODE_DEV_TOOLS/git-prompt.sh ]] && source $XCODE_DEV_TOOLS/git-prompt.sh
[[ -r /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
[[ -r /usr/local/etc/bash_completion.d/git-completion.bash ]] && source /usr/local/etc/bash_completion.d/git-completion.bash
[[ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]] && source /usr/local/etc/bash_completion.d/git-prompt.sh
if [[ -r /etc/bash_completion.d/git ]]; then
    source /etc/bash_completion.d/git
fi

PS1=$PS1'$(__git_ps1 " (%s)")'

PS1=$PS1'> '
#PS1=$PS1'$? 👻  $ '

alias venv='source $HOME/venv/bin/activate'
alias venv3='source $HOME/venv3/bin/activate'

type -p brew >/dev/null && hash brew 2>/dev/null && [[ -s `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]] && source `brew --prefix`/Library/Contributions/brew_bash_completion.sh

type -p brew >/dev/null && [[ -f `brew --prefix`/etc/bash_completion ]] && source `brew --prefix`/etc/bash_completion


complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

#PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

export LESS=FRSX

#PATH=$PATH:/usr/local/share/npm/bin

#if I am at console, capslock should be ctrl
if `tty | grep -- '/dev/tty[1-6]'` ; then loadkeys jrw.kmap.gz ; fi

### Added by the Heroku Toolbelt
if [[ -x /usr/local/heroku/bin ]]; then export PATH="/usr/local/heroku/bin:$PATH" ;fi


if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PYENV_ROOT=/usr/local/opt/pyenv
export LSCOLORS=ExfxcxdxCxegedabagacad
macdnsflush() {
    dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    rndc flush
}
TV=delays:/d/tv
MOVIES=delays:/d/movies
MUSIC=delays:Music/mp3
[[ -r .bashrc-$hostname ]] && source .bashrc-$hostname
[[ -r .bashrc-local ]] && source .bashrc-local

HOMES=/home
[[ -L /home ]] && HOMES=$(readlink /home)
PATH=$HOMES/$USER/go/bin:$PATH
[[ -L /usr/local/go/bin ]] && PATH=$PATH:/usr/local/go/bin

type -p lolcat >/dev/null && LOLCAT="lolcat -p .5" || LOLCAT=cat
type -p petname >/dev/null && PETNAME=$(petname -words=3) &&
type -p figlet >/dev/null && trap 'figlet $PETNAME | $LOLCAT; sleep 1' EXIT ||
{ type -p cowsay >/dev/null && trap 'cowsay "Have a nice day! $PETNAME"; sleep 1' EXIT ; }


type -p lolcat >/dev/null && LOLCAT="lolcat -p .5" || LOLCAT=cat
type -p figlet >/dev/null && trap 'figlet have a nice day | $LOLCAT' EXIT ||
{ type -p cowsay >/dev/null && trap 'cowsay "Have a nice day!"' EXIT ; }

export GREP_COLOR='1;30;40'
alias gdbrun='gdb -x ~/gdb.bt --args'

# color man pages - http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

alias duf='duf -hide special'

