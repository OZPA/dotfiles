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

link_files() {
  echo "link home directory dotfiles"
  cd ${DOT_DIRECTORY}
  for f in .??*
  do
      #無視したいファイルやディレクトリ
      [ "$f" = ".git" ] && continue
      [ "$f" = ".gitignore" ] && continue
      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
  done

  echo "link .config directory dotfiles"
  cd ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}
  for file in `\find . -maxdepth 8 -type f`; do
  #./の2文字を削除するためにfile:2としている
      ln -snfv ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}/${file:2} ${HOME}/${DOT_CONFIG_DIRECTORY}/${file:2}
  done

  echo "linked dotfiles complete!"
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

  echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"
}

update() {
  brew bundle dump -f
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
  update)
    update
    ;;
  *)
    usage
    ;;
esac

exit 0