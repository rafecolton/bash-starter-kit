function org() {
  if [ -n "$1" ] ; then
    export ORGNAME="$1"
  fi

  [[ -e "$ORGNAME" ]] && echo "[$ORGNAME]"
}

alias orgname=org

function orgkey() {
  if [ -n "$1" ] ; then
    export ORGKEY="$1"
  fi
  [[ -e "$ORGKEY" ]] && echo "[$ORGKEY]"
}

alias orgkeyname=orgkey

function org-berks() {
  if [ -z "$ORGNAME" ] ; then
    echo "No \$ORGNAME set" >&2
    return
  fi

  ORGCONFIG="$HOME/.berkshelf/$ORGNAME.config.json"

  LOCAL_ORGCONFIG_PATH="$PWD/.chef/org-configs/chef-config-$ORGNAME/berkshelf-config.json"

  if [ -s "$LOCAL_ORGCONFIG_PATH" ] ; then
    ORGCONFIG="$LOCAL_ORGCONFIG_PATH"
  fi

  ADDL_ARGS=""

  if [ "$1" == 'upload' ] ; then
    ADDL_ARGS='upload --no-freeze '
    shift
  fi

  COMMAND="$_berks_executable ${ADDL_ARGS}${@} -c \"$ORGCONFIG\""

  echo -e "\033[33;1m$COMMAND\033[0m"

  eval "$COMMAND"
}

export _berks_executable="${_berks_executable:-"$(which berks)"}"
alias bu='berks upload'
alias berks=org-berks
