# Bash Starter Kit

Starter kit for a `bash` shell. Geared towards macOS. May not be fully
compatible with Linux, but at least some differences are considered. If
you attempt to use on Linux and encounter any issues, please submit a
pull request! Contributions for compatibility happily accepted.
Contributions for new features will also be considered.

## Usage

To use this repo, copy all of these files into your `$HOME` directory.

**IMPORTANT:** Before copying anything, be sure to check if any of these
files already exist, especially `.bashrc` and `.bash_profile`. If so,
please consider a manual merge of these contents with your own so as not
to override any important settings you may already have.

## Bootstrapping (Optional)

### With `bootstrap.sh`

In addition to placing the files in your `$HOME` directory, there is an
optional bootstrap script, located at
[`bootstrap.sh`](/bootstrap.sh). Running this
script installs the following useful items:

* autoenv
* rbenv
* bundler &amp; rake gems (after rbenv)
* tmux
* janus (vim plugins)
* XVim (vim-style keyboard shortcuts for Xcode)
* json &amp; smartdc npm packages (for using the Joyent api)

### With `beer-me`

This repo includes a file named [`Caskfile`](/Caskfile), which is used by the
[`beer-me`](https://github.com/rafecolton/beer-me) utility to install a
number of useful packages and applications using homebrew and homebrew
cask. To use, following the instructions in the README for
installing `beer-me`, and run `beer-me` in the same directory as the
`Caskfile`. Any of the items can also be installed manually using the
`brew install`, `brew cask install`, and `brew tap` commands.

## Assumptions

### Ruby

This repo assumes you use `rbenv` and that you do not use `rvm`. If this
is not the case, consider adjusting the following files:

* `.bash_profile.d/rbenv.sh`
* `bootstrap.sh`
