# Make GPG work
export GPG_TTY=$TTY

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

# Autocompletion only appears to work if it's in this file
source ${HOME}/.cuddlefish/config

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/luke/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/luke/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/luke/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/luke/google-cloud-sdk/completion.zsh.inc'; fi
