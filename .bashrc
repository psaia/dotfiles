# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -f "$HOME/.env-exports" ]; then
	. "$HOME/.env-exports"
fi

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
KEYID=$(gpg -k --with-colons "${GPG_KEYID}" | awk -F: '/^pub:/ { print $5; exit }')
export KEYID=$KEYID

encrypt() {
	local input="$1"
	local output

	if [[ -d "$input" ]]; then
		# Archive the directory into a tar.gz file
		tar_file="${input%/}.$(date +%s).tar.gz"
		tar czf "$tar_file" "$input"
		input="$tar_file"
	fi

	# Generate the encrypted file name
	output="${input}.enc"

	# Encrypt the input
	gpg --encrypt --armor --output "$output" -r "$KEYID" "$input" &&
		echo "$input -> $output"
}

decrypt() {
	local input="$1"
	local output

	# Generate the decrypted file name by stripping the last `.enc`
	output=$(echo "$input" | rev | cut -d '.' -f 2- | rev)

	# Decrypt the input
	gpg --decrypt --output "$output" "$input" &&
		echo "$input -> $output"

	# Check if the decrypted file is a tar.gz and extract it
	if [[ "$output" == *.tar.gz ]]; then
		extracted_dir="${output%.tar.gz}"
		mkdir -p "$extracted_dir"
		tar xzf "$output" -C "$extracted_dir" &&
			echo "Extracted $output to $extracted_dir"
	fi
}

# env
export PS1=$(prompt_line)
export CODE_PATH="${HOME}/code"
export GOROOT="${HOME}/go/go${GO_VERSION}"
export GOBIN="${GOROOT}/bin"
export GOPATH="${GOROOT}/versioned_packages"
export N_PREFIX="${CODE_PATH}/node_versions"
export PATH="${GOBIN}:/usr/local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim
export SHELL=$(which bash)

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
