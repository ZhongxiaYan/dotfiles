dotfile_dir=`dirname "$0"`
cd $dotfile_dir

for file_name in `ls -a`; do
	if [[ ! $file_name =~ ^(\.|\.\.|\.git|install\.sh)$ ]]; then
		if [[ -e "$HOME/$file_name" ]]; then
			if [[ "$1" != "-f" ]]; then
				echo "$HOME/$file_name already exists, cannot link"
				continue
			else
				echo "$HOME/$file_name already exists, removing"
				rm -rf "$HOME/$file_name"
			fi
		fi
		ln -s "$dotfile_dir/$file_name" "$HOME/$file_name"
	fi
done
