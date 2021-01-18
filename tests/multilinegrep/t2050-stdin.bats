#!/usr/bin/env bats

load fixture

@test "search for three-line regexp with multiple matches in stdin" {
    run multilinegrep $'[Oo]ne.*\nt.*\n.*l' <(cat -- "$INPUT")
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
two/lines
three l..es
Ones here
two
else
one-two
three
the last" ]
}
