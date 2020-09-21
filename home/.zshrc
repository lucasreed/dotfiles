# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export TERM=xterm-256color
plugins=(git)
source $ZSH/oh-my-zsh.sh

if [[ -d ${HOME}/.zshrc.d ]]; then
  while read dotd; do
    source "${dotd}"
  done < <(find ${HOME}/.zshrc.d -follow -type f -not -name '*.disabled')
  unset dotd
fi
