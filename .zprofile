export GOPATH=$HOME/work/go
export N_PREFIX=$HOME/work/node_versions
export GOBIN=$GOPATH/bin
export PATH=$HOME/work/node_versions/bin:$PATH:$GOBIN
export GO111MODULE=auto
export VAULT_ADDR=https://vault-prd.dv.nyt.net

alias k='kubectl'

# Java development with jenv. :-{
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
