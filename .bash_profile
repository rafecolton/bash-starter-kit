source ~/.bashrc

function grep-src { grep "$1" * -r --color=auto $2 $3 $4 --exclude=*\.log --exclude tags; }

readonly DARK_GREEN="\[\033[32m\]"
readonly GOLD="\[\033[33;1m\]"
readonly GREEN="\[\033[32;1m\]"
readonly LIGHT_BLUE="\[\033[1;34m\]"
readonly LIGHT_GRAY="\[\033[0;37m\]"
readonly LIGHT_GREEN="\[\033[1;32m\]"
readonly LIGHT_PINK="\[\033[1;35m\]"
readonly PINK="\[\033[0;35m\]"
readonly RED="\[\033[31;1m\]"
readonly RESET="\[\033[0m\]"
readonly YELLOW="\[\033[0;33m\]"

if is_darwin ; then
  BREW_PREFIX=`brew --prefix`
  alias ctags="$BREW_PREFIX/bin/ctags"
  alias gvim="mvim --remote-send '<C-w>n'; mvim --remote-silent"
  alias vi='mvim -v'
  alias vim='mvim -v'
  alias ctl="launchctl"

  if [ -n "$BREW_PREFIX" ] ; then
    prepend_to_path "$BREW_PREFIX/sbin"
    prepend_to_path "$BREW_PREFIX/bin"
  fi

  # source homebrew-installed bash completion files
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi

if is_linux ; then
  alias vi='vim'
fi

if is_sunos ; then
  export ac_cv_func_dl_iterate_phdr='no'
  export rb_cv_have_signbit='no'
  export C_INCLUDE_PATH='/opt/local/include'
  export LIBRARY_PATH='/opt/local/lib:/lib/secure/64:/usr/lib/secure/64:/opt/local/gcc47/lib/amd64'
fi

export RUBY_CONFIGURE_OPTS="--disable-install-doc"
export RUBY_MAKE_OPTS=""

alias .g='source ~/.bash_profile'
alias a='activate'
alias ack='ag'
alias be='bundle exec'
alias c='clear'
alias grep='grep --color=auto'
alias tbe='time bundle exec'
alias t='time'

if is_darwin ; then
  alias l='ls -lFG'
  alias ll='ls -laFG'
  alias ls='ls -G'
else
  alias l='ls -lF --color=auto'
  alias ll='ls -laF --color=auto'
  alias ls='ls --color=auto'
fi

function wwich() {
  ls -lAFGh "$(which "$1")"
}

function p() {
  ps auxwww | grep "$@"
}

export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="l:ll:pwd:vmf:dvmf:isp"
export HISTFILESIZE=100000000
export HISTSIZE=1000000
shopt -s histappend # append instead of rewrite

# makes git grep wrap long lines instead of cutting them short
export LESS=FRX

if [ -d "$HOME/bin" ] ; then
  prepend_to_path "$HOME/bin"
fi

# source bash completion files
for completion_file in $(find $HOME/.bash_completion.d/ -type f)
do
  if [ ! -x "$completion_file" ]; then
    source "$completion_file"
  fi
done

if [ -d "$HOME/.bash_profile.d" ] ; then
  for f in $(find "$HOME/.bash_profile.d" -type f -name '*.sh') ; do
    source "$f"
  done
fi

append_to_path '/usr/local/share/npm/bin'

_pretty_prompt() {
  echo "${GREEN}(\$(uname))${LIGHT_BLUE} ::${YELLOW}[\w]${LIGHT_BLUE}::${RESET}\n${RED}::${LIGHT_BLUE}\u${RESET}Ə${PINK}\H${RESET}${LIGHT_GREY}::${LIGHT_BLUE}\$(org)${RESET}${LIGHT_GREY}::${GREEN}\$(sdc_env 2>/dev/null)${LIGHT_GREY}\$(__git_ps1)\n${RESET}> "
}

export PS1="$(_pretty_prompt)"
