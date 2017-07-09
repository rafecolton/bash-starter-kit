#!/bin/bash

if [ -d "$HOME/.rbenv" ]; then
  prepend_to_path "$HOME/.rbenv/bin"
  eval "$(rbenv init -)"
  prepend_to_path "$HOME/.rbenv/shims"
fi

# just in case rvm is being used
unset $GEM_HOME
