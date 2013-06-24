#!/usr/bin/env bash

set -e

function is_darwin() {
  uname | grep -i 'darwin' > /dev/null && [ $? -eq 0 ]
}

function is_linux() {
  uname | grep -i 'linux' > /dev/null && [ $? -eq 0 ]
}

function is_sunos() {
  uname | grep -i 'sunos' > /dev/null && [ $? -eq 0 ]
}

_install_tmux() {
  if is_darwin ; then
    if [ ! which brew ] ; then
      ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    fi
    brew install tmux
    brew install reattach-to-user-namespace
  elif is_linux ; then
    # un-tested
    sudo apt-get install tmux
    # sudo apt-get reattach-to-user-namespace # <- is this necessary?
  fi
}

_install_XVim(){
  if is_darwin ; then
    tmpdir="$(mktemp -dt "$0.XXXXXXXXXX")"
    pushd $tmpdir
    git clone git@github.com:JugglerShu/XVim.git
    echo 'Building XVim (this may take a minute)...'
    xcodebuild -project XVim/XVim.xcodeproj >/dev/null 2>&1
    if [ $? -ne 0 ] ; then
      exitcode=$?
      echo -e "\033[31mError building XVim\033[0m"
      exit $exitcode
    else
      ln1='Successfully installed XVim. XVim adds vim-like key bindings to Xcode.'
      ln2='To remove XVim: rm -rf $HOME/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/XVim.xcplugin'
      echo -e "\033[33m$ln1\n$ln2\033[0m"
    fi
  fi
}

_install_gems() {
  for gem in bundler rake git-duet ; do
    gem install "$gem"
  done
}

_install_rbenv() {
  pushd "$HOME" >/dev/null
  if [ -d .rbenv ] ; then
    mv .rbenv .old.rbenv
  fi
  git clone git://github.com/sstephenson/rbenv.git .rbenv
  mkdir -p .rbenv/plugins
  git clone git://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build
  git clone git://github.com/sstephenson/rbenv-gem-rehash.git .rbenv/plugins/rbenv-gem-rehash
  mkdir -p .bashrc.d
  mkdir -p .bash_profile.d
  cat > .bashrc.d/rbenv.sh <<EOF
if ! echo \$PATH | grep -q "\$HOME/.rbenv/bin" ; then
  export PATH="\$HOME/.rbenv/bin:\$PATH"
fi
EOF
  cat > .bash_profile.d/rbenv.sh <<EOF
eval "\$(rbenv init -)"
EOF
  source ~/.bash_profile
  rbenv install 1.9.3-p392
  rbenv global 1.9.3-p392
}

_install_janus() {
  pushd "$HOME" >/dev/null
  for f in .vimrc .gvimrc .vim ; do
    if [ -e $f ] ; then
      if [ -e ".old$f" ] ; then
        rm -rf ".old$f"
      fi
      mv "$f" ".old$f"
    fi
  done
  git clone https://github.com/carlhuda/janus.git .vim

  pushd .vim >/dev/null
  logfile=/tmp/janus-install.log
  echo "----> Installing Janus.  Log at $logfile"
  date > "$logfile"
  rake >> "$logfile" 2>&1
  echo
  popd >/dev/null
  popd >/dev/null
}

script_path() {
  (cd "$(dirname $0)" && echo "$(pwd -P)/$(basename $0)")
}

delete_self_and_exit() {
  rm -f "$(script_path)"
  exit 0
}

janus_only() {
  _install_janus
  source "$HOME/.bash_profile"
  delete_self_and_exit
}

main() {
  _install_rbenv
  _install_gems
  _install_janus
  _install_tmux
  _install_XVim
  source "$HOME/.bash_profile"
  delete_self_and_exit
}

if [ $# -gt 0 ] && [ "$1" == '--janus-only' ] ; then
  shift
  janus_only "$@"
else
  main "$@"
fi
