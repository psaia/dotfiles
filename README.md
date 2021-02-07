# dotfiles

### Setup

1. Exec brews below
2. Install [Inconsolata-g](/extra/Inconsolata-g.ttf)
3. Install the [iterm2 profile](.iterm2/Profiles.json)
4. `git clone --bare git@github.com:psaia/dotfiles.git $HOME/.cfg`
5. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout`
6. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no`
7. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init --recursive`
8. Continue to manage dotfiles by using `config` instead of `git`

### Vim Flow

**Add a new module:**

```bash
vimadd REPO_URL FOLDER_NAME
```

**Upgrade modules:**

```bash
vimup
```

**Remove a module:**

```bash
vimrm FOLDER_NAME
```

### Brew Installs

```bash
brew tap homebrew/cask-drivers
brew tap hashicorp/tap
brew install golang
brew install vim
brew install n
brew install tree
brew install wget
brew install ffmpeg
brew install direnv
brew install bash
brew install yq
brew install jq
brew install gh
brew install grpcurl
brew install golangci-lint
brew install hashicorp/tap/terraform
brew install hashicorp/tap/vault
brew install --cask garmin-express
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask sketch
brew install --cask karabiner-elements
brew install --cask adobe-creative-cloud
brew install --cask docker
brew install --cask monodraw
brew install --cask google-cloud-sdk
brew install --cask spotify
brew install --cask slack
brew install --cask keybase
brew install --cask brave-browser
```
