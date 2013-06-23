#!/usr/bin/env bash

function sdc() {
  ID=$1
  KEY="$(ls -1t ~/.ssh | grep "$ID" | grep -v pub | head -n 1)"
  export SDC_CLI_KEY="$ID"
  export SDC_CLI_KEY_ID="$ID"
  export SDC_CLI_IDENTITY="$HOME/$KEY"
  echo "$(env | grep SDC)"
}
