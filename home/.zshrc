# Make GPG work
export GPG_TTY=$TTY
export TERM=xterm-256color

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/luke/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/luke/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/luke/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/luke/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Autocompletion only appears to work if it's in this file
if [[ -f ${HOME}/.cuddlefish/config ]]; then
  . ${HOME}/.cuddlefish/config
fi

if [[ -d ${HOME}/.zshrc.d ]]; then
  while read dotd; do
    source "${dotd}"
  done < <(find ${HOME}/.zshrc.d -follow -type f -not -name '*.disabled')
  unset dotd
fi

export PATH=/Users/luke/go/bin:$PATH

