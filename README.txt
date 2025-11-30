pts-osxcross: compile C and C++ programs for macOS on Linux amd64
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pts-osxcross is a cross-compiler toolchain for compiling C and C++ programs
targeting macOS i386 and amd64 (x86_64) on Linux amd64. Apple Silicon (ARM
CPU) is not supported as a target. It contains the macOS 10.10 (darwin14)
SDK targeting OS X Yosemite 10.10 and earlier (Mac OS X Leopard 10.5 also
works). In addition to Clang 3.8.1 (C and C++ compiler), it also provides a
linker (ld), an assembler (as) and macOS binary tools (e.g. strip, otool,
lipo, ar, xar).

pts-osxcross is an easy-to-use binary release of the osxcross toolchain for
Linux amd64. It can be used directly after extraction, there is no need to
compile or install it, and it doesn't use the system libc (so it's
compatible with most versions of most Linux distributions, tested with
Ubuntu 14.04 and 18.04).

To download and extract:

  $ wget -O pts_osxcross_10.10.v2.sfx.7z https://github.com/pts/pts-osxcross/releases/download/v2/pts_osxcross_10.10.v2.sfx.7z
  $ chmod +x pts_osxcross_10.10.v2.sfx.7z
  $ ./pts_osxcross_10.10.v2.sfx.7z
  (This creates and populates directory pts_osxcross_10.10 .)

To download the sample program source:

 $ wget -O hello.c https://github.com/pts/pts-osxcross/raw/master/hello.c

The easiest way to use the tools on a modern Linux amd64 system is running
the programs in the `pathbin' or one of the `*-apple-darwin14/bin'
subdirectories. Run the tools as a regular user (no root access needed).

Example:

  $ pts_osxcross_10.10/pathbin/x86_64-apple-darwin14-clang -mmacosx-version-min=10.5 -W -Wall -O2 -o hello.darwin64 hello.c
  $ pts_osxcross_10.10/pathbin/x86_64-apple-darwin14-strip hello.darwin64

Alternative example:

  $ pts_osxcross_10.10/x86_64-apple-darwin14/clang -mmacosx-version-min=10.5 -W -Wall -O2 -o hello.darwin64 hello.c
  $ pts_osxcross_10.10/x86_64-apple-darwin14/strip hello.darwin64

The generated hello.darwin64 executable program file can be copied to and
run on a Mac. To run it on Linux, you may use Darling
(https://github.com/darlinghq/darling) or you can run macOS in VirtualBox or
QEMU on Linux.

You may also add the `pathbin' or one of the `*-apple-darwin14/bin'
subdirectories to your PATH.

Please note that for simplicity and reproducibility, pts-osxcross removes
all environment variables before running the compilers and other tools. (It
also sets up a PATH for them.)

Commands in other directories probably won't work directly, because they try
to find shared libraries in the wrong directory.

The compilers and other tools on the host Linux system are not used. Only
these are needed on the host: /bin/sh, /bin/readlink (optional),
/proc mounted, /tmp for tempary files, /dev/null.

Please note that pts-osxcross as of now has no special support for Cmake,
GNU autoconf (configure) or package managers (such as MacPorts and
Homebrew).

pts-osxcross was created this way:

* Copying all files out from the multiarch/crossbuild Docker image
  (https://hub.docker.com/r/multiarch/crossbuild). At the time of
  downloading it contained osxcross with macOS SDK 10.10 and Clang 3.8.1.
  (The Docker image was based on Debian GNU/Linux 9 (stretch).)
* Deleting files (including C and C++ compilers targeting Linux) not needed
  by osxcross. This reduced the total file size from 3.5 GiB to 0.73 GiB.
* Writing the ldxenv.pl Perl script for bind-mounting /lib64. This is needed
  so that the /lib64/ld-linux-x86-64.so.2 shipped with pts-osxcross will be
  used. (The system /lib64/ld-linux-x86-64.so.2 causes segfaults if it
  doesn't match the libc.so.6 version.)
* Copying
  https://github.com/pts/staticperl/releases/download/v2/staticperl-5.10.1.v2
  to remove dependency on the host system's Perl.
* Adding custom trampoline shell scripts to set up paths and call
  ldxenv.sh. These shell scripts are in the
  `pathbin' and `*-apple-darwin14/bin' subdirectories.

TODO(pts): Rewrite ldxenv.pl in C, link it statically with musl, drop
staticperl.

__END__
