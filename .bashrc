# git: dotfile management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

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

# env
export PS1=$(prompt_line)
export CODE_PATH="${HOME}/code"
export GOPATH="${CODE_PATH}/go"
export PATH="${HOME}/bin:/usr/local/bin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"
export PATH="${HOME}/config/node_versions/bin:${PATH}:${GOPATH}/bin"
export N_PREFIX="${CODE_PATH}/node_versions"
export CLOUDSDK_PYTHON=python2
export PATH=$HOME/.wasme/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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

# zsh: source things I'd like to keep out of git
if [[ -f "$HOME/.bashrcs" ]]; then
	source $HOME/.bashrcs
fi
. "$HOME/.cargo/env"
