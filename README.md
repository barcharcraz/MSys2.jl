# MSys2
This library wraps msys2 and provides a BinDeps source for
msys2's mingw64 repo.

When specifying packages use the plain package name without
the mingw-w64-x86_64- prefix, since that's implied by using
the Mingw64 provider.

Also of note is a type that acts somewhat like a nonstandard
string literal for commands, and runs the command using an msys2
bash shell. So writing `run(msys`ls`)` will run the ls command
using bash.
[![Build Status](https://travis-ci.org/barcharcraz/MSys2.jl.svg?branch=master)](https://travis-ci.org/barcharcraz/MSys2.jl)
