# First source bashrc
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

# SSH-Agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Aliases
alias ll='ls -hal'
alias gc='git commit -am'
alias gpd='git push origin develop'
alias gp='git push'
alias gpl='git pull'
alias gm='git merge --no-ff'
alias glog='git log'
alias gs='git status'
alias gch='git checkout'
alias gr='git reset --soft HEAD~'
alias gpm='git push origin master'
alias ga='git add .'

