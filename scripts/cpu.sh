#!/usr/bin/env bash
echo $(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf "%.1f%\n", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')
