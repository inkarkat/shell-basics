#!/usr/bin/env bats

load fixture

@test "search for three-line entire line regexp ending with empty line only matches the empty line" {
    run multilinegrep --line-regexp $'two\nelse\n' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'two\nelse' ]
}

@test "search for three-line entire line regexp with empty middle line only matches the empty line" {
    run multilinegrep --line-regexp $'.*o.*\n\nthree' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "four+more

three" ]
}

@test "search for three-line entire line regexp with empty starting line only matches the empty line" {
    run multilinegrep --line-regexp $'\nthree\n.*' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "
three
with" ]
}

@test "entire line search for two empty middle lines only matches the empty lines" {
    run multilinegrep --line-regexp $'[^ ]\+\n\n\n[^ ]\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "else

empty


or" ]
}
