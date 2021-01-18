#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run multilinegrep --does-not-exist
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}

@test "combinatation of --extended-regexp and --fixed-strings prints an error message" {
    run multilinegrep --extended-regexp --fixed-strings foo
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of -E|--extended-regexp, -F|--fixed-strings, -G|--basic-regexp can be passed." ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}

@test "combinatation of --extended-regexp and --basic-regexp prints an error message" {
    run multilinegrep --extended-regexp --basic-regexp foo
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of -E|--extended-regexp, -F|--fixed-strings, -G|--basic-regexp can be passed." ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}

@test "combinatation of --basic-regexp and --fixed-strings prints an error message" {
    run multilinegrep --basic-regexp --fixed-strings foo
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of -E|--extended-regexp, -F|--fixed-strings, -G|--basic-regexp can be passed." ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}

@test "no pattern prints usage" {
    run multilinegrep -- /dev/null
    [ $status -eq 2 ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}
