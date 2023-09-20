# dotfiles

1. Exec brews below
2. Install [Inconsolata-g](.vim/extra/Inconsolata-g.ttf)
3. Install the [iterm2 profile](.iterm2/Profiles.json)
4. `git clone --bare git@github.com:psaia/dotfiles.git $HOME/.cfg`
5. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout`
6. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no`
7. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init --recursive`
8. Continue to manage dotfiles by using `config` instead of `git`

## Brew Installs

```bash
brew bundle
```
