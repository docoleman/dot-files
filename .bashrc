#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

ulimit -S -c0

shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s checkwinsize
shopt -s checkhash
shopt -s histappend
shopt -s histverify
shopt -s sourcepath

shopt -u mailwarn
unset MAILCHECK

export EDITOR=/usr/bin/vim

PROMPT_COMMAND="history -a"
b=`tput bold`
n=`tput sgr0`
PS1='${b}[\u@\h \W]\$${n} '

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -r /usr/share/git/completion/git-completion.bash ] && . /usr/share/git/completion/git-completion.bash

#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------
# Keep the alias here, just so all of the less setup is together
alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

#-------------------------------------------------------------
# history
#-------------------------------------------------------------
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups

# Most important alias!
# Keep this in .bashrc so it will create the file the first time.
alias realias='$EDITOR ~/.bash_aliases; source ~/.bash_aliases'
