# My .zlogin file
# This file is evaluated after the login shell is ready

# Autorun the ssh-agent
. ~/.scripts/ssh_agent.sh

if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<~/.ssh-agent-output)" > /dev/null
fi
