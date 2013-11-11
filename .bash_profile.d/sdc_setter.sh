#!/usr/bin/env bash

function sdc() {
  ID=$1
  KEY="$(ls -1t ~/.ssh | grep "$ID" | grep -v pub | head -n 1)"
  export SDC_URL='https://us-sw-1.api.joyentcloud.com'
  export SDC_KEY_ID="$(ssh-keygen -l -f ~/.ssh/"$KEY" | awk '{ print $2 }')"
  export JOYENT_KEYNAME="$(whoami)"
  export JOYENT_KEYFILE="$HOME/.ssh/$KEY"
  echo "$(env | grep SDC)"
}
