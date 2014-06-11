This is the `.vim/` directory. Create a symlink from this directory in your home `ln -s ~/.vim/.vimrc ~/.vimrc` and then install the plugins via vundle `vim +PluginInstall +qall`.

I use iterm which is better for colors. That explains the `$ITERM_ENV` which determines if `background` is set to light or dark.
