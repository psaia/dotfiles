# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH
export ZSH="/Users/${USER}/.oh-my-zsh"

ZSH_THEME="nanotech"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/work/go
export N_PREFIX=$HOME/work/node_versions
export GOBIN=$GOPATH/bin
export PATH=$HOME/work/node_versions/bin:$PATH:$GOBIN
export GO111MODULE=auto
export GOPRIVATE="github.com/nytimes,github.com/nytm"
export VAULT_ADDR=https://vault-prd.dv.nyt.net
export CLOUDSDK_PYTHON=python2

eval "$(direnv hook zsh)"

alias k='kubectl'

# Easily switch versions of Go using Brew.
sgo() {
  brew install go@$1
  brew unlink go
  brew link go@$1 --overwrite --force
  go version
}
