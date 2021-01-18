#!/usr/bin/env bats

load fixture

@test "search for three-line block ending with empty line matches anything for the empty line" {
    run multilinegrep --block-regexp $'two\nelse\n' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'two\nelse\n\ntwo\nelse\none-two' ]
}

@test "search for three-line block with empty middle line only matches the middle line" {
    run multilinegrep --block-regexp $'o.*\n\nthree' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "four+more

three" ]
}

@test "search for three-line block with empty starting line matches anything for the empty line and last line" {
    run multilinegrep --block-regexp $'\nthree\n.*' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "
three
with
one-two
three
the last" ]
}

@test "search for two empty middle lines block matches anything for the empty lines" {
    run multilinegrep --block-regexp $'[^ ]\n\n\n[^ ]' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "else

empty


or" ]
}
