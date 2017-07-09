#!/bin/bash

# SAVED SSH AGENT
[[ -s "$HOME/.ssh/agent.out" ]] && source ~/.ssh/agent.out

# make sure ssh agent is always running
if ssh-add -l 2>&1 | grep -q -i -E 'could not open|No such file' || [[ ! -s "$HOME/.ssh/agent.out" ]] ; then
  eval `ssh-agent` &>/dev/null
fi

# save ssh agent info
echo "export $(env | grep SSH_AUTH_SOCK | head -n 1)" > "$HOME/.ssh/agent.out"
