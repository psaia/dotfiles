export PATH="$HOME/bin:/usr/local/bin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/work/node_versions/bin:$PATH:$GOBIN"
export PATH="/usr/local/sbin:$PATH"
export ZSH="/Users/${USER}/.oh-my-zsh"
export GOPATH=$HOME/work/go
export N_PREFIX=$HOME/work/node_versions
export GOBIN=$GOPATH/bin
export GO111MODULE=auto
export CLOUDSDK_PYTHON=python2

# Dotfile repo.
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Enable direnv.
eval "$(direnv hook zsh)"

# zsh: Configure.
ZSH_THEME="nanotech"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# zsh: Prevent the sharing of history between tabs.
unsetopt inc_append_history
unsetopt share_history

# zsh: Source things I'd like to keep out of git.
if [[ -f "$HOME/.zshrcs" ]]; then
    source $HOME/.zshrcs
fi

# Add a new vim plugin.
vimadd() {
  cd ~/
  config submodule add $1 .vim/pack/psaia/start/$2
  config add .gitmodules .vim/pack/psaia/start/$2
  config status
}

# Upgrade all vim plugins.
vimupgrade() {
  cd ~/
  config submodule update --remote --merge
  config status
}

# Easily switch versions of Go using Brew.
genv() {
  brew install go@$1
  brew unlink go
  brew link go@$1 --overwrite --force
  go version
}

# Switch versions of Java. Looking forward to removing this.
jenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}
eval export PATH="/Users/pete/.jenv/shims:${PATH}"
export JENV_SHELL=zsh
export JENV_LOADED=1
unset JAVA_HOME
source '/usr/local/Cellar/jenv/0.5.4/libexec/libexec/../completions/jenv.zsh'
jenv rehash 2>/dev/null
jenv refresh-plugins
source "/Users/pete/.jenv/plugins/export/etc/jenv.d/init/export_jenv_hook.zsh"