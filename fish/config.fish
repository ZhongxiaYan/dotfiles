bind \cb backward-kill-path-component
bind \cw backward-kill-bigword
bind \cd kill-bigword

if test -e $__fish_config_dir/custom.fish
    source $__fish_config_dir/custom.fish
end

alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias df "df -Tha --total"
alias du "du -sh"
alias free "free -mt"
alias ps "ps aux"
alias psg "ps aux | grep -v grep | grep -i -e VSZ -e"
alias wget "wget -c"
alias myip "curl http://ipecho.net/plain; echo"
alias tb "tensorboard --logdir"

function extract --description "Expand or extract bundled & compressed files"
  set --local ext (echo $argv[1] | awk -F. '{print $NF}')
  switch $ext
    case tar  # non-compressed, just bundled
      tar -xvf $argv[1]
    case gz
      if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar  # tar bundle compressed with gzip
        tar -zxvf $argv[1]
      else  # single gzip
        gunzip $argv[1]
      end
    case tgz  # same as tar.gz
      tar -zxvf $argv[1]
    case bz2  # tar compressed with bzip2
      tar -jxvf $argv[1]
    case rar
      unrar x $argv[1]
    case zip
      unzip $argv[1]
    case '*'
      echo "unknown extension"
  end
end

function mk
    mkdir -p $argv && cd $argv
end

function mkdircp
    set src $argv[1]
    set dst $argv[2]
    if string match -q "*/*" dst
        set dst (basename $dst)
    end
    mkdir -p $dst
    cp -r $src $dst
end

function mkcp
    mkdircp $argv
    cd $argv[2]
end

function port
    set remote $argv[2]
    set local $argv[3] $remote
    ssh -N -L "localhost:"$local":localhost:"$remote $argv[1]
end

function rn
    set src (basename (pwd))
    cd ..
    mv src $argv[1]
    cd $argv[1]
end

function v
    set path $argv[1]
    if test -d $path
        ls $path
    else
        cat $path
    end
end

function vv
    set path $argv[1]
    if test -d $path
        ls $path
    else
        vim $path
    end
end

function rmexcept
    set files (ls)
    if test (count $argv) -eq 0
        echo 'Need at least one argument'
        return 1
    end
    for file in $files
        if contains $file $argv
            echo Skipping $file
        else
            rm -r $file
        end
    end
end

function mvall
    for path in $argv[1..-2]
        mv $path $argv[-1]
    end
end

function cpall
    for path in $argv[1..-2]
        cp $path $argv[-1]
    end
end

function rm_pwd
    set old_pwd (pwd)
    cd ..
    rm -rf $old_pwd
end

function filterout -V orig -V remove
    for x in $orig
        if not contains $x $remove
            echo $x
        end
    end
end

function filter -V orig -V keep
    for x in $orig
        if contains $x $keep
            echo $x
        end
    end
end

function dpython
    set orig $argv
    set remove -u
    set new_argv (filterout)
    python -m pdb -c continue $argv
end

function cdn
    set n $argv[1] 1
    for i in (seq $n[1])
        cd (ls -1dt ./*/ | head -n 1)
    end
end

function cdf
    set n $argv[1] 1
    for i in (seq $n[1])
        cd (ls -d */ | head -n 1)
    end
end

function cdl
    set n $argv[1] 1
    for i in (seq $n[1])
        cd (ls -d */ | tail -n 1)
    end
end
