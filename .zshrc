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
plugins=(git)
source $ZSH/oh-my-zsh.sh
setopt prompt_subst
PROMPT='%F{blue}%~%f %F{green}$(branch_name)%f %F{white}$%f '

# direnv: install
eval "$(direnv hook zsh)"

# zsh: prevent the sharing of history between tabs
unsetopt inc_append_history
unsetopt share_history

# zsh: source things I'd like to keep out of git
if [[ -f "$HOME/.zshrcs" ]]; then
    source $HOME/.zshrcs
fi

# vim: install module (`vimadd git@github.com:preservim/nerdtree.git nerdtree`)
vimadd() {
  cd ~/
  config submodule add $1 .vim/pack/psaia/start/$2
  config add .gitmodules .vim/pack/psaia/start/$2
  config status
}

# vim: remove module (`vimrm nerdtree`)
vimrm() {
  cd ~/
  config submodule deinit -f .vim/pack/psaia/start/$1
  config rm -f .vim/pack/psaia/start/$1
  config -Rf .git/modules/.vim/pack/psaia/start/$1
  config status
}

# vim: upgrade module
vimup() {
  cd ~/
  config submodule update --recursive
  config status
}

# go: switch go versions using brew
genv() {
  brew install go@$1
  brew unlink go
  brew link go@$1 --overwrite --force
  go version
}

# zsh: branch for prompt
branch_name() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '['$branch']'
  fi
}

