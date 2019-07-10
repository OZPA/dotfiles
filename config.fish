# superior /usr/local/bin than /usr/bin
set -x PATH /usr/local/bin $PATH

# superior nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH


function fish_user_key_bindings
  bind \cr peco_select_history # Bind for peco select history to Ctrl+R
  bind \c] peco_select_ghq_repository # Bind for peco select ghq
end