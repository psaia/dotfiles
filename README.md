# dotfiles

### General

* Use the [nord](https://github.com/arcticicestudio/nord-vim/) color kit for [iterm2](https://www.iterm2.com/).
* Install [Inconsolata-g](/extra/Inconsolata-g.ttf).
* Install the [iterm2 profile](.iterm2/Profiles.json).

### Setup

1. `git clone --bare git@github.com:psaia/dotfiles.git $HOME/.cfg`
2. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout`
3. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no`
4. `git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init --recursive`
5. Continue to manage dotfiles by using `config` instead of `git`.

### Vim Module Mgmt

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
brew install go
brew install n
brew install tree
brew install wget
brew install ffmpeg
brew install direnv
brew cask install iterm2
brew cask install google-chrome
brew cask install sketch
brew cask install karabiner-elements
brew cask install adobe-creative-cloud
brew cask install docker
brew cask install monodraw
brew cask install google-cloud-sdk
brew cask install spotify
brew cask install slack
brew cask install keybase
brew cask install brave-browser

brew tap homebrew/cask-drivers
brew cask install garmin-express
```
