# dotfiles

This is how I use a computer.

## Brew Installs

```bash
brew bundle
```

Open up iterm2 and install the [profile](.iterm2/Profiles.json) so fonts look
nice.

## Configure git/config

```bash
git clone --bare git@github.com:psaia/dotfiles.git $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init --recursive
```

Continue to manage dotfiles by using `config` instead of `git`.
