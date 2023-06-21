eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

. "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/petesaia/code/google-cloud-sdk/path.bash.inc' ]; then . '/Users/petesaia/code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/petesaia/code/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/petesaia/code/google-cloud-sdk/completion.bash.inc'; fi
