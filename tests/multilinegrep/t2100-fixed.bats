#!/usr/bin/env bats

load fixture

@test "search for single line literal string as plain argument" {
    run multilinegrep --fixed-strings 'one-line' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single line literal string as --regexp argument" {
    run multilinegrep --fixed-strings --regexp 'one-line' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single line literal string with multiple matches" {
    run multilinegrep --fixed-strings 'one' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
one-two" ]
}

@test "search for single line literal string with no matches returns 1" {
    run multilinegrep --fixed-strings 'doesNotMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line literal string as plain argument" {
    run multilinegrep --fixed-strings $'one-line here\ntwo/lines\nthree' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line literal string as --regexp argument" {
    run multilinegrep --fixed-strings --regexp $'one-line here\ntwo/lines\nthree' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for two-line literal string with multiple matches" {
    run multilinegrep --fixed-strings $'here\ntwo' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
two/lines
Ones here
two" ]
}

@test "search for three-line literal string with no matches returns 1" {
    run multilinegrep --fixed-strings $'does\nNot\nMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line literal string with second line not matching returns 1" {
    run multilinegrep --fixed-strings $'one-line here\nthree\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line literal string with last line not matching returns 1" {
    run multilinegrep --fixed-strings $'one-line here\ntwo/lines\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
