from __future__ import print_function, absolute_import

# run this file through install.sh

import os
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-f', action='store_true')
args = parser.parse_args()

dotfiles = os.path.dirname(__file__)

link_excludes = ['.git', 'install.sh', 'install.py', 'fish']

for file in os.listdir(dotfiles):
    if file in link_excludes:
        continue
    path = os.path.join(dotfiles, file)
    dst = os.path.join(os.environ['HOME'], file)
    if os.path.exists(dst) and not args.f:
        print('%s already exists, skipping link' % path)
    else:
        if os.path.islink(dst):
            os.remove(dst)
        print('Linked %s -> %s' % (dst, path))
        os.symlink(path, dst)

