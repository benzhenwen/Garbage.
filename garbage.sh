#!/bin/sh
echo -ne '\033c\033]0;garbage\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/garbage.x86_64" "$@"
