# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    if [ ! -z "`which dircolors`" ]; then
        eval `dircolors -b`
        alias ls='ls --color=auto'
    else
        alias ls='ls -G'
    fi
    #alias rt='ionice -c 3 rtorrent -O 'schedule=watchdir,0,1,load_start=*.torrent' -- `ls -rtQ *.torrent`'
    alias rt="rtorrent -O 'schedule=watchdir,0,1,load_start=*.torrent'"
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
if [[ ! -z $DISPLAY ]];then
    alias vi='vim -X'
    alias vim='vim -X'
fi
[[ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && alias vim=/Applications/MacVim.app/Contents/MacOS/Vim && alias vi=vim

if [[ -z "$HOSTNAME" ]]; then HOSTNAME=`hostname`;fi
if [[ `hostname -s` == "gogogogogogogo" ]]; then HOSTNAME='gogo'; fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in
if [[ -z "$debian_chroot" && -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# A color and a non-color prompt:
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
#PS1='${debian_chroot:+($debian_chroot)}\e[1;31m[${PWD}:${WINDOW}${TMUX_PAIN}]\e[1;32m[\A]\e[m\e[1;36m\n[\u@\h:\$]\e[m '
if [[ "$ITERM_PROFILE" == "Default Light" ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\D{%d%m%y-%H%M%S}\[\033[01;31m\]jrw@${HOSTNAME}\[\033[00m\]:{${WINDOW}${TMUX_PANE}}\[\033[01;34m\]\w\[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\D{%d%m%y-%H%M%S}\[\033[01;32m\]jrw@${HOSTNAME}\[\033[00m\]:{${WINDOW}${TMUX_PANE}}\[\033[01;34m\]\w\[\033[00m\]'
fi

#function sshauthsock () {
#SSH_AUTH_SOCK=$(lsof  -b  -a -p $(ps x | grep ssh-agen[t] | awk '{print $1}')  -a -U 2>/dev/null | awk '/3u/{print $8}')
#}

: ${TMPDIR:=/tmp}
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen*)
    if [[ ! -z "`find --version 2>/dev/null | grep GNU`" ]];then
        UNAME=$(uname)
        if [[ "$UNAME" == "Linux" ]]; then
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}:${WINDOW}\007";[[ -z "$SSH_AUTH_SOCK" ]] && export SSH_AUTH_SOCK=`find $TMPDIR/ssh*  -type s -printf "%T+ %p\n" 2>/dev/null | head -1 | cut -f 2 -d " "`'
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

if [[ -r ~/.keychain/$HOSTNAME-sh ]]; then
. ~/.keychain/$HOSTNAME-sh
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
[[ -r /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
[[ -r /usr/local/etc/bash_completion.d/git-completion.bash ]] && source /usr/local/etc/bash_completion.d/git-completion.bash
[[ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]] && source /usr/local/etc/bash_completion.d/git-prompt.sh
if [[ -r /etc/bash_completion.d/git ]]; then
    source /etc/bash_completion.d/git
fi
PS1=$PS1'$(__git_ps1 " (%s)") '

PS1=$PS1'👻  $ '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

#[[ -s "$HOME/venv/bin/activate" ]] && source "$HOME/venv/bin/activate" # This uses a default python virtualenv
alias venv='source $HOME/venv/bin/activate'

type -p brew >/dev/null && hash brew 2>/dev/null && [[ -s `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]] && source `brew --prefix`/Library/Contributions/brew_bash_completion.sh

type -p brew >/dev/null && [[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion

complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

export LESS=FRSX

if [[ -x /usr/libexec/java_home ]];then
export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
fi
if [[ -r "$HOME"/.ec2/pk-*.pem ]];then
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
fi
if [[ -r "$HOME"/.ec2/cert-*.pem ]];then
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
fi
if [[ -r /usr/local/Library/LinkedKeys/ec2-api-tools/jars ]];then
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
fi
if [[ -r /usr/local/Cellar/ec2-ami-tools/1.3-45758/jars ]]; then
export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.3-45758/jars"
fi
if hash rbenv 2>/dev/null; then
eval "$(rbenv init -)"
fi
[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh
PATH=$PATH:/usr/local/share/npm/bin

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

#GOROOT=/usr/local/Cellar/go/1.3/libexec
#[[ -d $GOROOT ]] && export GOROOT || unset GOROOT
HOMES=/home
[[ -L /home ]] && HOMES=$(readlink /home)
export GOPATH=$HOMES/jrwren/go
PATH=$GOPATH/bin:$PATH

type -p petname >/dev/null && PETNAME=$(petname -words=3)
type -p cowsay >/dev/null && trap 'cowsay "Have a nice day! $PETNAME"; sleep 1' EXIT

goctags () {
    godeps ./... | awk -v GOPATH=$GOPATH '{print GOPATH"/src/"$1}' | xargs  ctags -R .
}

[[ -d /usr/local/Cellar/gnu-sed/4.2.2/libexec/gnubin ]] && export PATH=/usr/local/Cellar/gnu-sed/4.2.2/libexec/gnubin:$PATH
#export CDPATH=$GOPATH/src/github.com:$GOPATH/src/code.google.com/p:$GOPATH/src/launchpad.net

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;30;40'
alias gdbrun='gdb -x ~/gdb.bt --args' 
alias gdbrun='gdb -x ~/gdb.bt --args' 

[[ -t 0 ]] && [[ -f $HOME/.ssh/id_rsa-canonical ]] && ! ssh-add -l 1>/dev/null && ssh-add $HOME/.ssh/id_rsa-canonical

