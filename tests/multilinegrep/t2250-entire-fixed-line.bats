#!/usr/bin/env bats

load fixture

@test "search for single entire line literal string as plain argument" {
    run multilinegrep --line-regexp --fixed-strings 'just one-line here' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep --line-regexp --fixed-strings 'just one-line here' "$INPUT")" = "$output" ]
}

@test "search for single entire line literal string as --regexp argument" {
    run multilinegrep --line-regexp --fixed-strings --regexp 'just one-line here' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep --line-regexp --fixed-strings --regexp 'just one-line here' "$INPUT")" = "$output" ]
}

@test "search for single entire line literal string with multiple matches" {
    run multilinegrep --line-regexp --fixed-strings 'three' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "three
three" ]
    [ "$(grep --line-regexp --fixed-strings 'three' "$INPUT")" = "$output" ]
}

@test "search for single entire line literal string with no matches returns 1" {
    run multilinegrep --line-regexp --fixed-strings 'doesNotMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    [ "$(grep --line-regexp --fixed-strings 'doesNotMatch' "$INPUT")" = "$output" ]
}

@test "search for entire three-line literal string as plain argument" {
    run multilinegrep --line-regexp --fixed-strings $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for entire three-line literal string as --regexp argument" {
    run multilinegrep --line-regexp --fixed-strings --regexp $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for two-line literal string with multiple matches" {
    run multilinegrep --line-regexp --fixed-strings $'two\nelse' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "two
else
two
else" ]
}

@test "search for three-line literal string with inner matches" {
    run multilinegrep --line-regexp --fixed-strings $'one-line here\no/line\nthree' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line literal string as block match" {
    run multilinegrep --line-regexp --fixed-strings --regexp $'one-line here\ntwo/lines\nthree' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line literal string that matches the entire line" {
    run multilinegrep --line-regexp --fixed-strings $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for entire three-line literal string with no matches returns 1" {
    run multilinegrep --line-regexp --fixed-strings $'does\nNot\nMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for entire three-line literal string with second line not matching returns 1" {
    run multilinegrep --line-regexp --fixed-strings $'just one-line here\nthree\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for entire three-line literal string with last line not matching returns 1" {
    run multilinegrep --line-regexp --fixed-strings $'just one-line here\ntwo/lines\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
