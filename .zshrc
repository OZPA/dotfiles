# Path to your oh-my-zsh installation.
export ZSH="/Users/kenichi.hasegawa/.oh-my-zsh"

# OH-MY-ZSH THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"
source ~/.oh-my-zsh/themes/alien/alien.zsh

# Plugins
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# PATH関連
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
## M1 brew
export PATH="/opt/homebrew/bin:$PATH"

# brew caskでのインストールディレクトリ変更
export HOMEBREW_CASK_OPTS="--appdir=/Applications"