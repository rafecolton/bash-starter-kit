# set GOROOT if go is installed via homebrew
if [ -d /usr/local/Cellar/go ] ; then
  export GOROOT="/usr/local/Cellar/go/`ls /usr/local/Cellar/go | tail -1`"
else
  export GOROOT="/usr/local/go"
fi

export GOPATH="$HOME/gopath"
export GOBIN="$GOPATH/bin"
export GO15VENDOREXPERIMENT=1

prepend_to_path "$GOROOT/bin"
append_to_path "$GOPATH/bin"
