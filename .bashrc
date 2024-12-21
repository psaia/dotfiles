# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# prompt: branch for prompt
branch_name() {
	local branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [[ $branch != "" ]]; then
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

# Make gpg key id more accessible
export KEYID=DED8ACAB0256BA11

secret () {
  output="${1}".$(date +%s).enc
  gpg --encrypt --armor --output ${output} \
    -r $KEYID "${1}" && echo "${1} -> ${output}"
}

reveal () {
  output=$(echo "${1}" | rev | cut -c16- | rev)
  gpg --decrypt --output ${output} "${1}" && \
    echo "${1} -> ${output}"
}

# env
export PS1=$(prompt_line)
export CODE_PATH="${HOME}/code"
export GOROOT="${HOME}/go/go1.23.4"
export GOBIN="${GOROOT}/bin"
export GOPATH="${GOROOT}/versioned_packages"
export N_PREFIX="${CODE_PATH}/node_versions"
export PATH="${GOBIN}:$PATH:${CODE_PATH}/istio-1.16.1/bin"
export NVM_DIR="$HOME/.nvm"

# Required by gpg2 in order to sign commits
export GPG_TTY=$(tty)

# git: dotfile management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# rust: things
if [[ -d "$HOME/.cargo" ]]; then . "$HOME/.cargo/env"; fi

# misc aliases
alias k=kubectl
alias vim="nvim"
alias vi="nvim"
export EDITOR=nvim

# history: always append, a lot of lines, and important stuff
shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTIGNORE='ls:bg:fg:history:cd'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

# direnv
eval "$(direnv hook bash)"

# source things I'd like to keep out of git
if [[ -f "$HOME/.bashrcs" ]]; then
	source $HOME/.bashrcs
fi
