# superior /usr/local/bin than /usr/bin
set -x PATH /usr/local/bin $PATH
set PATH "/opt/homebrew/bin:/usr/local/bin:$PATH"


# superior nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# prompt directory not abbreviation
set -g fish_prompt_pwd_dir_length 0

# key bind
function fish_user_key_bindings
  bind \cr peco_select_history # Bind for peco select history to Ctrl+R
  bind \c] peco_select_ghq_repository # Bind for peco select ghq
end

# alias
balias g git
balias nbrew nodebrew
eval (hub alias -s)