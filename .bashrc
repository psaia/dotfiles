# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# vim: install module (`vimadd git@github.com:preservim/nerdtree.git nerdtree`)
vimadd() {
	cd ~/
	config submodule add $1 .vim/pack/$USER/start/$2
	config add .gitmodules .vim/pack/$USER/start/$2
	config status
}

# vim: remove module (`vimrm nerdtree`)
vimrm() {
	cd ~/
	config submodule deinit -f .vim/pack/$USER/start/$1
	config rm -f .vim/pack/$USER/start/$1
	config -Rf .git/modules/.vim/pack/$USER/start/$1
	config status
}

# vim: upgrade module
vimup() {
	cd ~/
	config submodule update --recursive --remote
	config status
}

# go: switch go versions using brew
genv() {
	brew install go@$1
	brew unlink go
	brew link go@$1 --overwrite --force
	go version
}

# prompt: branch for prompt
branch_name() {
	local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [[ $branch != "" ]]
	then
		echo ' ['$branch']'
	fi
}

# prompt: format the line
prompt_line() {
	local _GREEN=$(tput setaf 2)
	local _BLUE=$(tput setaf 4)
	local _RESET=$(tput sgr0)
	echo "\[${_BLUE}\]\W\[${_RESET}${_GREEN}\]\$(branch_name)\[${_RESET}\] \$ \[\e[0m\]"
}

# history: quickly grep
hs() {
	history | grep "${1}"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/petesaia/code/google-cloud-sdk/path.bash.inc' ]; then . '/Users/petesaia/code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/petesaia/code/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/petesaia/code/google-cloud-sdk/completion.bash.inc'; fi

# env
export PS1=$(prompt_line)
export CODE_PATH="${HOME}/code"
export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
export N_PREFIX="${CODE_PATH}/node_versions"
export PATH="$PATH:/Users/petesaia/code/istio-1.16.1/bin"

# git: dotfile management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# rust: things
if [[ -d "$HOME/.cargo" ]]; then
	. "$HOME/.cargo/env"
fi

# pyenv: easy python version switching
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# misc aliases
alias k=kubectl

# direnv: install
eval "$(direnv hook bash)"

# history: always append, a lot of lines, and important stuff
shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTIGNORE='ls:bg:fg:history:cd'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

# source things I'd like to keep out of git
if [[ -f "$HOME/.bashrcs" ]]; then
	source $HOME/.bashrcs
fi
