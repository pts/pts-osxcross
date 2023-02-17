#! /bin/sh
# by pts@fazekas.hu at Fri Feb 17 03:27:13 CET 2023

set -ex
find pts_osxcross_10.10 -type f -name '*~' -delete
rm -f pts_osxcross_10.10/etc/group
rm -f pts_osxcross_10.10/etc/passwd
rm -f pts_osxcross_10.10/etc/shadow
for D in pts_osxcross_10.10/home/*; do
  test -d "$D" && rmdir "$D"
done
time 7z a -sfx../../../../../../../../../../../../../../../../"$PWD"/tiny7zx -t7z -mx=7 -md=8m -ms=on pts_osxcross_10.10.sfx.7z pts_osxcross_10.10

: "$0" OK.
