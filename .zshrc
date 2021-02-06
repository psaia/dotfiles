# globals
export PATH="$HOME/bin:/usr/local/bin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/work/node_versions/bin:$PATH:$GOBIN"
export PATH="/usr/local/sbin:$PATH"
export ZSH="/Users/${USER}/.oh-my-zsh"
export GOPATH=$HOME/work/go
export N_PREFIX=$HOME/work/node_versions
export GOBIN=$GOPATH/bin
export GO111MODULE=auto
export CLOUDSDK_PYTHON=python2

# git: dotfile management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# zsh: initialize
ZSH_THEME="nanotech"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# direnv: install
eval "$(direnv hook zsh)"

# zsh: prevent the sharing of history between tabs
unsetopt inc_append_history
unsetopt share_history

# zsh: source things I'd like to keep out of git
if [[ -f "$HOME/.zshrcs" ]]; then
    source $HOME/.zshrcs
fi

# vim: install plugin
# vimadd REPO FILE_NAME
vimadd() {
  cd ~/
  config submodule add $1 .vim/pack/psaia/start/$2
  config add .gitmodules .vim/pack/psaia/start/$2
  config status
}

# vim: upgrade plugins
vimupgrade() {
  cd ~/
  config submodule update --remote --merge
  config status
}

# go: switch go versions using brew
genv() {
  brew install go@$1
  brew unlink go
  brew link go@$1 --overwrite --force
  go version
}
