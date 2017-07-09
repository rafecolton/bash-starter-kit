# NOTE: this file should only contain non-interactive things like umask,
# environmental variables, whereas ~/.bash_profile should contain all
# interactive-type things like aliases, functions, and the fancy PS1

umask 027

export GIT_PS1_SHOWSTASHSTATE="<nonempty>"
export GIT_PS1_SHOWUNTRACKEDFILES="<nonempty>"
export GIT_PS1_SHOWDIRTYSTATE="<nonempty>"
export GIT_PS1_SHOWUPSTREAM="auto"

set -o vi

function is_darwin() {
  uname | grep -i 'darwin' > /dev/null && [ $? -eq 0 ]
}

function is_linux() {
  uname | grep -i 'linux' > /dev/null && [ $? -eq 0 ]
}

function is_sunos() {
  uname | grep -i 'sunos' > /dev/null && [ $? -eq 0 ]
}

# fixes some bug for tmux, I think
if is_darwin ; then
  if [ -f /etc/profile ] ; then
    PATH=''
    source /etc/profile
  fi
fi

function prepend_to_path {
  if [ ! -z $1 ] && ! echo ":$PATH:" | grep -q ":$1:" ; then
    export PATH="$1:$PATH"
  fi
}

function append_to_path {
  if [ ! -z $1 ] && ! echo ":$PATH:" | grep -q ":$1:" ; then
    export PATH="$PATH:$1"
  fi
}

append_to_path "/usr/local/sbin"
append_to_path "/opt/local/bin"
append_to_path "/usr/local/mysql/bin"

export EDITOR=vim
export TERM=xterm-256color
export PAGER='less -FSRX'

# source other .bashrc* files
for f in .bashrc.local .bashrc_local .bashrc_$(whoami) ; do
  test -s "$HOME/$f" && source "$HOME/$f"
done

# source files in ~/.bashrc.d/
if [ -d "$HOME/.bashrc.d" ] ; then
  for f in $(find "$HOME/.bashrc.d" -type f -name '*.sh') ; do
    source "$f"
  done
fi
