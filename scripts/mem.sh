#!/usr/bin/env bash
#free | grep Mem | awk '{printf "%.1f%\n", $3/$2 * 100.0}'
free | grep Mem | awk '{printf "%.0fM/%.2fG\n", $3/1000, $2/1000000}'
