#### ~/.vim/

.vim contains both vim related files and various dot files that get symlinked.

1. `git clone https://github.com/petesaia/.vim.git ~/.vim`
2. `ln -s ~/.vim/.vimrc ~/.vimrc`
2. `ln -s ~/.vim/.zshenv ~/.zshenv`
3. `:PlugInstall` - though it should install automatically if you have npm installed.

#### Extra osx provisioning to help when my computer gets stolen/replaced.

```bash
brew install go
brew install n
brew install tree
brew install wget
brew install ffmpeg
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

* Use the [nord](https://github.com/arcticicestudio/nord-vim/) color kit for [iterm2](https://www.iterm2.com/).
* Install [Inconsolata-g](/extra/Inconsolata-g.ttf) font for iterm2.

#### .bash_profile customizations

```bash
export PS1="\e[2m[\u] \W\e[0m \e[33m$ \e[0m"
```
