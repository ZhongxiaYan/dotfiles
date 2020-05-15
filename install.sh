git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

dotfile_dir=`dirname "$0"`
python $dotfile_dir/install.py $@

