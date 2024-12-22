# dotfiles

This is how I use a computer.

I use [kitty](https://sw.kovidgoyal.net/kitty/).

## Brew Installs

```bash
brew bundle
```

## Non-brew installs

* npm is required for the TS language server: `npm install -g typescript typescript-language-server`
* protobuf language server: `go install github.com/bufbuild/buf-language-server/cmd/bufls@latest`

## Configure git/config

```bash
git clone --bare git@github.com:psaia/dotfiles.git $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init --recursive
```

Continue to manage dotfiles by using `config` instead of `git`.

## Go Management

I find it easier and more straight forward to manage Go versions without a fancy
too specific for doing so.

1. Download a tarball from https://go.dev/dl/
2. Decompress and rename it to `~/go/goX.X.X`.
3. Update the `GOROOT` in the .bashrc.
