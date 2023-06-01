#!/bin/sh source-this-script

trace()
(
    functionexport "$@" 2>/dev/null # Export any argument with error suppressions; this saves us from duplicating some sort of command-line argument parsing here.
    command trace "$@"
)
