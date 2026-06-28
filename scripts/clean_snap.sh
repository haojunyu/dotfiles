#!/bin/bash

# 清理所有已禁用的 snap 版本
set -eu

LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' | \
while read snapname revision; do
    echo "remove $snapname $revision"
    sudo snap remove "$snapname" --revision="$revision"
done
