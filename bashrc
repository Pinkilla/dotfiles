# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
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
    alias md='mkdir'

	 #my aliases
	 alias df='df -h '
	 alias du='du -h '

    # set a fancy prompt
    #PS1='\u@\h:\w\$ '
	PS1="\[\e[0;37m\]\u@\h\[\e[0m\]:$(if test $(echo $PWD | sed "s,$HOME,~," |wc -c) -gt 20; then echo "...${PWD: -20}"; else echo "\w"; fi)\[\e[0;32m\]$\[\e[0m\] "


    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
fi

# Corrections petites fautes 
shopt -s cdspell 

#java
export PATH=/usr/local/java/jdk/bin:$PATH
	PATH=$PATH:/usr/local//java/UMLGraph-5.6/bin/
export CLASSPATH=.:/usr/local/java/jdk:~/home/java
	CLASSPATH=$CLASSPATH:/usr/local/java/mysql-connector-java.jar
	CLASSPATH=$CLASSPATH:/usr/local/java/junit/junit-4.3.jar
	CLASSPATH=$CLASSPATH:/usr/local/java/javamail/mail.jar
	CLASSPATH=$CLASSPATH:/usr/local/java/javamail/lib/smtp.jar
	CLASSPATH=$CLASSPATH:/usr/local/java/jaf/activation.jar
	CLASSPATH=$CLASSPATH:/usr/local/java/jargs/classes
	CLASSPATH=$CLASSPATH:/usr/local/java/jlayer/jl1.0.jar
	CLASSPATH=$CLASSPATH:/usr/share/java
	CLASSPATH=$CLASSPATH:/usr/local/java/UMLGraph-5.6/lib/UmlGraph.jar
	CLASSPATH=$CLASSPATH:/usr/local/java/jdk/lib/tools.jar
	CLASSPATH=$CLASSPATH:/home/pit/home/java/projet/tournament-pbt/resources/itextpdf-5.3.5.jar


#C
export CC=gcc

#ActionScript
#export PATH=$PATH:/usr/local/share/mtasc


# Ant
export PATH=$PATH:/usr/local/java/ant/bin
export ANT_HOME=/usr/local/java/ant/
export JAVA_HOME=/usr/local/java/jdk

# Pour BOUML
export BOUML_ID=42 

# éditor and pager
export EDITOR=vim
#export BROWSER=/usr/local/share/firefox/firefox
export BROWSER=/usr/bin/firefox-my
# Configuration de less avec couleurs
export LESS='-F -i -J -m -R -W -n4 -z-6'
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

