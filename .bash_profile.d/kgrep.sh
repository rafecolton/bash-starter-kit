#!/usr/bin/env bash

function kgrep() {
  (a chef-repo && knife status "name:*$1*")
}
