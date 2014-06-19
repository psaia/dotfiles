This is the `.vim/` directory.

1. `git clone https://github.com/petesaia/.vim.git ~/.vim`
2. `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
3. `ln -s ~/.vim/.vimrc ~/.vimrc`
4. `:PluginInstall`

Use the newest vim with lua so neocomplete works (`brew install vim --with-lua`). I use iterm which is better for colors. That explains the `$ITERM_ENV` which determines if `background` is set to light or dark.
