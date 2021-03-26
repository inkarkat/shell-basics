#!/usr/bin/env bats

load fixture

@test "search for existing two-line regexp" {
    run multilinegrep --basic-regexp $'just.*\n.' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
two/lines" ]
}

@test "search for two-line regexp where the second line match does not exist" {
    run multilinegrep --basic-regexp $'just.*\nNOT' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for non-existing two-line regexp" {
    run multilinegrep --basic-regexp $'just.*\nNOT' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for two-line regexp where input stops at the first line" {
    run multilinegrep --basic-regexp $'just.*\n.' "$INPUT2"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
