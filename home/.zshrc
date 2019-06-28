# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/luke/.oh-my-zsh"
export TERM=xterm-256color

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias e="code ."
alias k="kubectl"
alias kgn="kubectl get namespaces"
alias kgs="kubectl get services"
alias kgp="kubectl get pods"
alias kgd="kubectl get deployments"
alias c="cuddlectl"
alias a="$CUDDLEFISH_VENV/bin/auditomation"

source ~/.purepower.sh
# Start Powerline Config
#    INSERT POWERLINE CHANGES HERE
# End Powerline Config

# GCP Tools
export PATH="$HOME/tools/google-cloud-sdk/bin:$PATH"

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Allow pyenv to manage virtualenvs as well
eval "$(pyenv virtualenv-init -)"

# Enables cuddlefish which has a virtualenv as its runtime
source $HOME/.cuddlefish/config

# Source asdf which is a version manager for various tools
. /usr/local/opt/asdf/asdf.sh

# Make sure vim (not minimal vi) is the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# ydiff options I always want to be in use
YDIFF_OPTIONS="-s"

# Make commandline editing vim-like
# Also making sure reverse history search still works with ^R
set -o vi
bindkey "^R" history-incremental-search-backward

kc() {
  kubectl -n "${namespace}" $@
}

generate_kubeconfig_from_sa() {
  namespace="$1"
  serviceaccount="$2"

  sa_secret_name=$(kc get serviceaccount "${serviceaccount}" -o 'jsonpath={.secrets[0].name}')

  context_name="$(kubectl config current-context)"
  kubeconfig_old="${KUBECONFIG}"
  cluster_name="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"${context_name}\")].context.cluster}")"
  server_name="$(kubectl config view -o "jsonpath={.clusters[?(@.name==\"${cluster_name}\")].cluster.server}")"
  cacert="$(kc get secret "${sa_secret_name}" -o "jsonpath={.data.ca\.crt}" | base64 --decode)"
  token="$(kc get secret "${sa_secret_name}" -o "jsonpath={.data.token}" | base64 --decode)"

  export KUBECONFIG="$(mktemp)"
  kubectl config set-credentials "${serviceaccount}" --token="${token}" >/dev/null
  ca_crt="$(mktemp)"; echo "${cacert}" > ${ca_crt}
  kubectl config set-cluster "${cluster_name}" --server="${server_name}" --certificate-authority="$ca_crt" --embed-certs >/dev/null
  kubectl config set-context "${cluster_name}" --cluster="${cluster_name}" --user="${serviceaccount}" >/dev/null
  kubectl config use-context "${cluster_name}" >/dev/null

  KUBECONFIG_DATA=$(cat "${KUBECONFIG}")
  rm ${KUBECONFIG}
  echo "${KUBECONFIG_DATA}"
  export KUBECONFIG="${kubeconfig_old}"
}

source "$HOME/.homesick/repos/homeshick/homeshick.sh"