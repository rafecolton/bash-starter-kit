# Bash Starter Kit

Starter kit for a `bash` shell. Geared towards macOS. May not be fully
compatible with Linux, but at least some differences are considered. If
you attempt to use on Linux and encounter any issues, please submit a
pull request! Contributions for compatibility happily accepted.
Contributions for new features will also be considered.

## Usage

To use this repo, copy all of these files (except for README.md and
LICENSE) into your `$HOME` directory.

**IMPORTANT:** Before copying anything, be sure to check if any of these
files already exist, especially `.bashrc` and `.bash_profile`. If so,
please consider a manual merge of these contents with your own so as not
to override any important settings you may already have.

### Configuring Git

To finish setting up `git` after a fresh install, be sure to set a
global author and name:

```bash
git config --global user.name "Firstname Lastname"
git config --global user.email "youremail@example.com"
```

### Configuring Sublime Text as Your Default Editor

This repo assumes you use `vim` as your default text editor. If you
would prefer to use Sublime Text, consider the following additional
setup.

1. Install Sublime Text

    ```bash
    # install sublime text 3
    brew cask install sublime-text
    ```

    ...or, if Sublime Text is already installed, symlink the `subl` utility into place

    ```bash
    which subl || ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    ```
1. Set your default editor to sublime

    ```bash
    # or manually replace the line in .bash_profile where EDITOR is set
    echo 'export EDITOR=subl' >> ~/.bash_profile
    ```
1.  Set your git commit editor to sublime text

    ```bash
    git config --global core.editor "subl -n -w"
    ```

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

## Cleanup

After placing all files from this repo, be sure to take the following
steps to remove unnecessary files from your `$HOME` directory:

1. Remove bootstrap files

    ```bash
    # remove bootstrap files
    rm ~/bootstrap.sh ~/Caskfile

    # remove README and LICENSE files if present
    rm ~/README.md ~/LICENSE
    ```

1. Star this repo on GitHub 😄
