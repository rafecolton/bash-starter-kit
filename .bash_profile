source ~/.bashrc

function grep-src { grep "$1" * -r --color=auto $2 $3 $4 --exclude=*\.log --exclude tags; }

DARK_GREEN="\[\033[32m\]"
GOLD="\[\033[33;1m\]"
GREEN="\[\033[32;1m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_PINK="\[\033[1;35m\]"
PINK="\[\033[0;35m\]"
RED="\[\033[31;1m\]"
RESET="\[\033[0m\]"
YELLOW="\[\033[0;33m\]"

if is_darwin ; then
  BREW_PREFIX=`brew --prefix`
  alias ctags="$BREW_PREFIX/bin/ctags"
  alias gvim="mvim --remote-send '<C-w>n'; mvim --remote-silent"
  alias vi='mvim -v'
  alias vim='mvim -v'

  if [ -n "$BREW_PREFIX" ] ; then
    for path in "$BREW_PREFIX/sbin" "$BREW_PREFIX/bin" ; do
      prepend_to_path "$path"
    done
  fi

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
alias ca='cookbook_activate'
alias be='bundle exec'
alias bu='berks upload --no-freeze'
alias grep='grep --color=auto'
alias tbe='time bundle exec'
alias t='time'
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'
alias rdb='bundle exec rails dbconsole'
alias sc='script/console'
alias ss='script/server'
alias sdb='script/dbconsole'

if is_darwin ; then
  alias l='ls -lFG'
  alias ll='ls -laFG'
  alias ls='ls -G'
else
  alias l='ls -lF --color=auto'
  alias ll='ls -laF --color=auto'
  alias ls='ls --color=auto'
fi

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

for completion_file in $(find $HOME/.bash_completion.d/ -type f)
do
  if [ ! -x "$completion_file" ]; then
    source "$completion_file"
  fi
done

if [ -d "$HOME/.rbenv" ]; then
  prepend_to_path "$HOME/.rbenv/bin"
  eval "$(rbenv init -)"
  prepend_to_path "$HOME/.rbenv/shims"
fi

unset $GEM_HOME

if [ -d "$HOME/.bash_profile.d" ] ; then
  for f in $(find "$HOME/.bash_profile.d" -type f -name '*.sh') ; do
    source "$f"
  done
fi

source ~/.autoenv/activate.sh
[[ -s "$HOME/.ssh/agent.out" ]] && source ~/.ssh/agent.out

append_to_path '/usr/local/share/npm/bin'

_pretty_prompt() {
  echo "${GREEN}(\$(uname))${LIGHT_BLUE} ::${YELLOW}[\w]${LIGHT_BLUE}::${RESET}\n${RED}::${LIGHT_BLUE}\u${RESET}Ə${PINK}\H${RESET}${LIGHT_GREY}::${LIGHT_BLUE}\$(org)${RESET}${LIGHT_GREY}::${GREEN}\$(sdc_env 2>/dev/null)${LIGHT_GREY}\$(__git_ps1)\n${RESET}> "
}

export PS1="$(_pretty_prompt)"
