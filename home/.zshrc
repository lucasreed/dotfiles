# Make GPG work
export GPG_TTY=$TTY
export TERM=xterm-256color

if [[ -d ${HOME}/.zshrc.d ]]; then
  while read dotd; do
    source "${dotd}"
  done < <(find ${HOME}/.zshrc.d -follow -type f -not -name '*.disabled')
  unset dotd
fi

export PATH=/Users/luke/go/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH=/Users/luke/go/bin/:/usr/local/sbin:/Users/luke/.nvm/versions/node/v14.18.1/bin:/Users/luke/.local/share/solana/install/active_release/bin:/Users/luke/.krew/bin:/usr/local/opt/curl/bin:/Users/luke/.asdf/shims:/usr/local/Cellar/asdf/0.8.1_1/libexec/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/luke/.nvm/versions/node/v14.18.1/bin:/Users/luke/.local/share/solana/install/active_release/bin:/Users/luke/.krew/bin:/usr/local/opt/curl/bin:/usr/local/opt/asdf/bin:/Users/luke/.cargo/bin
export PATH=$PATH:/Users/luke/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/luke/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/luke/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/luke/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/luke/google-cloud-sdk/completion.zsh.inc'; fi
