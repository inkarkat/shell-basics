#!/usr/bin/env bats

load fixture

@test "search for three-line literal string ending with empty line matches anything for the empty line" {
    run multilinegrep --fixed-strings $'two\nelse\n' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'two\nelse\ntwo\nelse' ]
}

@test "search for three-line literal string with empty middle line matches anything for the empty line" {
    run multilinegrep --fixed-strings $'o\n\nthree' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
two/lines
three l..es
four+more

three" ]
}

@test "search for three-line literal string with empty starting line matches anything for the empty line" {
    run multilinegrep --fixed-strings $'\nthree\nwith' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "four+more

three
with" ]
}

@test "literal search for two empty middle lines matches anything for the empty lines" {
    run multilinegrep --fixed-strings $'empty\n\n\nor' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "empty


or" ]
}
