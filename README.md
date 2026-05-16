```
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

> This is how I use a computer.

|                    |                                          |
| ------------------ | ---------------------------------------- |
| **Terminal**       | [kitty](https://sw.kovidgoyal.net/kitty/) |
| **Shell**          | bash                                     |
| **Editor**         | neovim                                   |
| **Signing**        | YubiKey (no-touch, 24h PIN cache)        |
| **Dotfile mgmt**   | bare git repo at `$HOME/.cfg`            |

---

## Fresh machine setup

Each step depends on the previous one — run them in order.

### 1. Xcode Command Line Tools

```bash
xcode-select --install
```

Provides `git` and the compiler toolchain that Homebrew and `gpg` need.

### 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the post-install hints to add brew to your shell (the tracked `.bashrc`
already does `eval "$(/opt/homebrew/bin/brew shellenv)"`).

### 3. Bootstrap dotfiles

```bash
git clone --bare git@github.com:psaia/dotfiles.git $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init --recursive
```

Going forward, manage dotfiles with the `config` alias (defined in `.bashrc`)
instead of `git`.

### 4. Local environment

```bash
cp ~/.env-exports.example ~/.env-exports
```

Edit `~/.env-exports` to set real values for `GO_VERSION` and `GPG_KEYID` —
`.bashrc` sources this file at startup.

### 5. Brew bundle

```bash
brew bundle
```

Reads `~/Brewfile`. Installs every CLI, cask, language server, and security
tool used by the rest of this setup.

### 6. Language servers not on brew

```bash
npm install -g typescript typescript-language-server
go install github.com/bufbuild/buf-language-server/cmd/bufls@latest
```

### 7. Restore GPG / YubiKey

The YubiKey alone isn't enough — gpg also needs the public key in its keyring.
Easiest path is to fetch it from GitHub, then populate the card stubs:

```bash
curl https://github.com/psaia.gpg | gpg --import
gpg --card-status   # YubiKey plugged in; creates keygrip stubs in private-keys-v1.d/
```

Fallback if GitHub is unreachable: import from the offline `.asc` backup
(`gpg --import path/to/<fpr>-<date>.asc`) before running `--card-status`.

Git commit/tag signing is configured in the tracked `.gitconfig`. To re-create
from scratch:

```bash
git config --global user.signingkey B4E629C6454A2D74
git config --global commit.gpgsign true
git config --global tag.gpgSign true
```

### 8. Go

I manage Go versions manually instead of with a dedicated version manager:

1. Download a tarball from https://go.dev/dl/.
2. Decompress and rename to `~/go/goX.X.X`.
3. Set `GO_VERSION` in `~/.env-exports`. `.bashrc` builds `GOROOT` from it.

---

## Daily use

**Prime the GPG cache** at the start of a session so signed commits don't prompt
mid-flow:

```bash
gpg-unlock   # signs a dummy input to trigger pinentry; PIN cached ~24h
```

**Manage dotfiles** with the `config` alias instead of `git`:

```bash
config status
config add ~/.bashrc
config commit -m "tweak prompt"
config push
```
