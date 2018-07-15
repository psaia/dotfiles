#### ~/.vim/

1. `git clone https://github.com/petesaia/.vim.git ~/.vim`
2. `ln -s ~/.vim/.vimrc ~/.vimrc`
3. `:PlugInstall` - though it should install automatically if you have npm installed.

#### Extra osx provisioning to help when my computer gets stolen/replaced.

```bash
brew install go
brew install node
brew cask install iterm2
brew cask install google-chrome
brew cask install sketch
brew cask install karabiner-elements
brew cask install adobe-creative-cloud
brew cask install docker
brew cask install monodraw
brew cask install google-cloud-sdk
brew cask install spotify
```

* Use the [dracula](https://draculatheme.com/iterm/) color kit for [iterm2](https://www.iterm2.com/).
* Install the lovely [Inconsolata-g](/extra/Inconsolata-g.ttf) font for iterm2.

#### .bash_profile customizations

```bash
export PS1="\e[2m[\u] \W\e[0m \e[33m$ \e[0m"
```
