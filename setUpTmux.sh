#! /bin/bash

wget GITHUB_URL -o ~/.tmux.conf.mcjones

echo 'alias tmuxmicheal='tmux -S /tmp/mcjones.tmux -f /root/.tmux.conf.mcjones'
