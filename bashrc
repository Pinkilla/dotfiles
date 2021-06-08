# my bashrc Pit

# If running interactively, then:
if [ "$PS1" ]; then

     # don't put duplicate lines in the history. See bash(1) for more options
	 # and add more lines in history default value is 500
	 export HISTCONTROL=ignoredups
	 export HISTFILESIZE=1000
	 export HISTSIZE=1000
	 

    # enable color support of ls and also add handy aliases
    #eval `dircolors -b`
    alias ls='ls --color=auto -h '
    alias ll='ls --color -h -l'
    alias la='ls --color -h -l -a'
    alias md='mkdir'

	 #my aliases
	 alias df='df -h '
	 alias du='du -h '
	 alias givm='gvim '


    # set a fancy prompt
    #PS1='\u@\h:\w\$ '
	#PS1="\[\e[0;37m\]\u@\h\[\e[0m\]:\w\[\e[0;32m\]$\[\e[0m\] "
	split_pwd(){
  		W=$(pwd | sed 's|'"$HOME"'|~|')
		if [ $(echo $W | wc -c) -gt 30 ]; then
		    echo $W | awk -F '/' '\
		    	$3!=$(NF-1) {print $1 "/" $2 "/…/" $(NF-1) "/" $NF}\
		    	$3==$(NF-1) {print $0}\
		    '
		else
			echo $W;
		fi
	}
	PS1="\[\e[0;37m\]\u@\h\[\e[0m\]:\$(split_pwd)\[\e[0;32m\]$\[\e[0m\] "

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
fi

# Corrections for small errors 
shopt -s cdspell 

#java
export PATH=~/bin:/usr/local/java/jdk/bin:$PATH
export CLASSPATH=.:/usr/local/java/jdk:~/home/java
	CLASSPATH=$CLASSPATH:/usr/local/java/jdk/lib/tools.jar

#C
export CC=gcc

# éditor and pager
export EDITOR=vim
export BROWSER=/usr/bin/firefox-my
# configure less with colors
export LESS='-F -X -i -J -m -R -W -n -x4 -z-6'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[1;47m'     # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export PAGER=less

export TERM=screen-256color

# Une note de mon blog. un type de fichier en couleur
#export LS_COLORS="$LS_COLORS:*.java=00;31"

#github config - http://github.com
#
# ----- start config
#
SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
		ssh-add ~/.ssh/id_rsa
		ssh-add ~/.ssh/id_ed25519
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
	test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
	. "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi

#
# ----  end config github
#


# Remettre ce damné beep à 0 de temps en temps
xset b off


# Set titel for terminal
function set_title {
	echo -n -e "\033]0;$1\007"
}




# running jekyll as non-root and without sudo
export GEM_HOME=${HOME}/.gems
export PATH=${PATH}:${HOME}/.gems/bin


alias disoff="export DISPLAY=:0.0"
alias dison="export DISPLAY=:1"

alias smallps="source ~/bin/smallps; clear"

# fzf config
source /usr/share/bash-completion/completions/fzf
source /usr/share/doc/fzf/examples/key-bindings.bash 

export FZF_DEFAULT_OPTS="--height 50% \
	--multi \
	--inline-info \
	--preview '[[ \$(file --mime {}) =~ binary ]] \
		&& echo {} is a binary file \
		|| bat --color=always --style=plain,changes {} \
		2>/dev/null | head -300 ' \
	--preview-window='hidden' \
	--bind='f2:toggle-preview,ctrl-a:select-all+accept'"

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

