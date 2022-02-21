# ccalc
## Synopsis
An advanced text-based command-line calculator app.
- Supports complex arithmetic, integer arithmetic and bitwise operations
- Supports implied multiplication (multiplication by justaposition)
- Supports 8, 16, 32, 64 and 128 bit integer types
- Supports binary, octal, decimal and hexadecimal numbers, both integer and
floating point (and complex)
- Supports floating point numbers with 100 decimal significant digits (+ guard
digits)
## Dependencies
This project depends on another of my projects, ccalc-lib. That project provides
the backend to this project's CLI frontend.
- ccalc-lib's header files are assumed to be discoverable in a "ccalc" directory
in the include search path; e.g., /usr/local/include/ccalc.
- The lib files libccalc-rel.a (release library) and libccalc-dbg.a (debugging
library) are assumed to be discoverable in the lib path; e.g., located in
/usr/local/lib.

This project also depends on Boost because ccalc-lib does so; see ccalc-lib for
details.

This project has GNU extensions enabled because ccalc-lib does so.
## Build Quick Help
- 'make' or 'make install' builds the release executable as described below for
'make release', and then installs it under /usr/bin
- 'make debug' builds the debug executable in a "debug" directory under the
current working directory
- 'make release' builds the release executable in a "release" directory under
the current working directory
- 'make uninstall' deletes the execuable from /usr/bin
- The makefile provides more make targets and options; peruse it for details