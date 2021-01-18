#!/usr/bin/env bats

load fixture

@test "quiet search for single line regexp returns 0" {
    run multilinegrep --quiet 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "quiet search for single line regexp with multiple matches returns 0" {
    run multilinegrep --quiet '[Oo]ne' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "quiet search for single line regexp with no matches returns 1" {
    run multilinegrep --quiet 'doesN.tMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "quiet search for three-line regexp with multiple matches" {
    run multilinegrep --quiet $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "quiet search for three-line regexp with no matches returns 1" {
    run multilinegrep --quiet $'does\nN.t\nMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
