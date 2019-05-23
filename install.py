from __future__ import print_function, absolute_import

# run this file through install.sh

import os
dotfiles = os.path.dirname(__file__)

link_excludes = ['.git', 'install.sh', 'install.py']

for file in os.listdir(dotfiles):
    if file in link_excludes:
        continue
    path = os.path.join(dotfiles, file)
    if os.path.exists(path):
        print('%s already exists, skipping link' % path)
    else:
        dst = os.path.join(os.environ['HOME'], file)
        print('Linked %s -> %s' % (dst, path))
        os.symlink(path, dst)
