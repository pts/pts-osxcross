#! /bin/sh --
# by pts@fazekas.hu at Wed Feb 15 14:51:30 CET 2023
#
# Uses: clang version 3.8.1-24, MacOSX10.10.sdk.
#
# TODO(pts): Add libgcc.a.
set -ex

TOOLCHAINBASE=pts_osxcross_10.10

TOOLCHAINPREFIX="$TOOLCHAINBASE"/x86_64-apple-darwin14/bin/
"$TOOLCHAINPREFIX"gcc -mmacosx-version-min=10.5 -W -Wall -O2 -o hello.darwin64 hello.c
"$TOOLCHAINPREFIX"strip hello.darwin64

TOOLCHAINPREFIX="$TOOLCHAINBASE"/i386-apple-darwin14/bin/
"$TOOLCHAINPREFIX"gcc -mmacosx-version-min=10.5 -W -Wall -O2 -o hello.darwin32 hello.c
"$TOOLCHAINPREFIX"strip hello.darwin32

: "$0" OK.
