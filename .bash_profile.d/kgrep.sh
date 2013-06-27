#!/usr/bin/env bash

function kgrep() {
  (a tools-modcloth-chef-repo && knife status | grep "$1")
}
