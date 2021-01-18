#!/usr/bin/env bats

load fixture

@test "search for three-line regexp ending with empty line matches anything for the empty line" {
    run multilinegrep $'two\nelse\n' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'two\nelse\n\ntwo\nelse\none-two' ]
}

@test "search for three-line regexp with empty middle line matches anything for the empty line" {
    run multilinegrep $'o\n\nthree' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
two/lines
three l..es
four+more

three" ]
}

@test "search for three-line regexp with empty starting line matches anything for the empty line" {
    run multilinegrep $'\nthree\n.*' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "two/lines
three l..es
four+more

three
with
one-two
three
the last" ]
}

@test "search for two empty middle lines matches anything for the empty lines" {
    run multilinegrep $'[^ ]\n\n\n[^ ]' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "Start
just one-line here
two/lines
three l..es
four+more

three
with
two
else

empty
or
Ones here
two
else" ]
}
