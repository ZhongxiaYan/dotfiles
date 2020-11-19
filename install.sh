if [ "$(uname)" == "Darwin" ]; then
    brew install fish
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt install fish
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

dotfile_dir=`dirname "$0"`
python $dotfile_dir/install.py $@ || python3 $dotfile_dir/install.py $@
ln -s ~/.custom.sh ~/.bash_custom
if [ ! -L ~/.config/fish ]; then
    ln -s ~/.dotfiles/fish ~/.config/fish
    ln -s ~/.dotfiles/fish ~/.fish
fi
