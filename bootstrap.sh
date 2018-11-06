#!/usr/bin/env bash

GOLD=$(echo -e "\033[33;1m")
RESET=$(echo -e "\033[0m")
GREEN=$(echo -e "\033[32;1m")
RED=$(echo -e "\033[31;1m")

function is_darwin() {
  uname | grep -i 'darwin' > /dev/null && [ $? -eq 0 ]
}

function is_linux() {
  uname | grep -i 'linux' > /dev/null && [ $? -eq 0 ]
}

function is_sunos() {
  uname | grep -i 'sunos' > /dev/null && [ $? -eq 0 ]
}

_install_autoenv() {
  git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
}

_install_tmux() {
  if is_darwin ; then
    if ! which brew ; then
      echo "please install homebrew first" >&2
      exit 1
    fi
    if ! which tmux ; then
      brew install tmux
      brew install reattach-to-user-namespace
      cat <<EOB >> "$HOME/.tmux.conf"

# fixes problem with GUI apps started from tmux (MVIM) not having access to user's clipboard
# see here https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
# clone, compile ('make'), and copy binary to ~/bin in order for this line to work
set-option -g default-command "reattach-to-user-namespace -l bash"
EOB
    fi
  elif is_linux ; then
    sudo apt-get install -y tmux
    sudo apt-get upgrade -y tmux
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
      echo -e "${GOLD}$ln1\n$ln2${RESET}"
    fi
  fi
}

_install_gems() {
  for gem in bundler rake ; do
    is_linux && sudo gem install "$gem"
    is_darwin && gem install "$gem"
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
  is_linux && sudo $(which rbenv) install 2.3.0
  is_darwin && rbenv install 2.3.0
  rbenv global 2.3.0
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

_install_sdc_commands() {
  if is_linux ; then
    sudo apt-get install -y npm
    source ~/.bash_profile
    sudo npm install -g json
    sudo npm update -g json
    sudo npm install -g smartdc
    sudo npm update -g smartdc
  elif is_darwin ; then
    brew install npm
    npm install -g json
    npm update -g json
    npm install -g smartdc
    npm update -g smartdc
  fi
}

_install_docker_vim_syntax() {
  for dir in ftdetect snippets syntax ; do
    mkdir -p "$HOME/.vim/$dir"
  done

  git clone https://github.com/ekalinin/Dockerfile.vim.git /tmp/Dockerfile.vim
  pushd /tmp/Dockerfile.vim >/dev/null
  make install
  popd
  rm -rf /tmp/Dockerfile.vim
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

_install_vim_plugins() {
  test -d ~/.vim/bundle/Vundle.vim || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
}

main() {
  is_linux && sudo apt-get update -yq
  _install_autoenv
  _install_rbenv
  _install_gems
  _install_janus
  _install_tmux
  _install_XVim
  _install_sdc_commands
  _install_vim_plugins
  source "$HOME/.bash_profile"
  delete_self_and_exit
}

if [ $# -gt 0 ] && [ "$1" == '--janus-only' ] ; then
  shift
  janus_only "$@"
else
  main "$@"
fi
