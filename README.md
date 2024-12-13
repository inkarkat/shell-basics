# Shell Basics

_A collection of basic shell scripts that are either useful on its own (in interactive sessions), or offer generic functionality for higher-level scripts._

![Build Status](https://github.com/inkarkat/shell-basics/actions/workflows/build.yml/badge.svg)

### Dependencies

* Bash, GNU `awk`, GNU `sed`
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.
* The [shell/bash/aliases.sh](shell/bash/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/completions.sh](shell/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
* The [shell/bash/completions.sh](shell/bash/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
* The [shell/wrappers.sh](shell/wrappers.sh) script (meant to be sourced in `.bashrc`) defines Bash wrappers around provided commands (for additional features in the current shell).
* The [profile/exports.sh](profile/exports.sh) sets up configuration; it only needs to be sourced once, e.g. from your `.profile`.
