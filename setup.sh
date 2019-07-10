#!/bin/bash

set -e
OS="$(uname -s)"
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_TARBALL="https://github.com/ozpa/dotfiles/tarball/master"
DOT_CONFIG_DIRECTORY=".config"
REMOTE_URL="https://github.com/ozpa/dotfiles.git"

has() {
  type "$1" > /dev/null 2>&1
}

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  deploy
  initialize
  update
Arguments:
  -f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles.
  -h Print help (this message)
EOF
  exit 1
}

while getopts "fh" opt; do
  case ${opt} in
    f)
      OVERWRITE=true
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

# If missing, download and extract the dotfiles repository
if [ ! -d ${DOT_DIRECTORY} ]; then
  echo "Downloading dotfiles..."
  mkdir ${DOT_DIRECTORY}

  if has "git"; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi

  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
fi

cd ${DOT_DIRECTORY}
source ./lib/brew.sh
source ./lib/fisher.sh

link_files() {
  echo "link home directory dotfiles"
  cd ${DOT_DIRECTORY}
  for f in .??*
  do
    # If you have ignore files, add file/directory name here
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = ".editorconfig" ]] && continue

    # Force remove the vim directory if it's already there
    [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -f ${HOME}/${f}
    if [ ! -e ${HOME}/${f} ]; then

      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  ## config.fish
  conf_dest=".config/fish/config.fish"
  conf_src="config.fish"
  fisv_dest=".config/fish/fish_variables"
  fisv_src="fish/fish_variables"

  [ -n "${OVERWRITE}" -a -e ${HOME}/${conf_dest} ] && rm -f ${HOME}/${conf_dest}
  ln -snfv ${DOT_DIRECTORY}/${conf_src} ${HOME}/${conf_dest}
  ln -snfv ${DOT_DIRECTORY}/${fisv_src} ${HOME}/${fisv_dest}

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

initialize() {
  # ignore shell execution error temporarily
  set +e

  case ${OSTYPE} in
    darwin*)
      run_brew
      ;;
    *)
      echo $(tput setaf 1)Working only OSX$(tput sgr0)
      exit 1
      ;;
  esac

  run_fisher

  echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"
}

brew_update() {
  brew bundle dump -f
  echo "Update Brewfile!"
}

fisher_update() {
  set +e

  run_fisher
}

command=$1
[ $# -gt 0 ] && shift

case $command in
  deploy)
    link_files
    ;;
  init*)
    initialize
    ;;
  brew_update)
    brew_update
    ;;
  fisher_update)
    fisher_update
    ;;
  *)
    usage
    ;;
esac

exit 0