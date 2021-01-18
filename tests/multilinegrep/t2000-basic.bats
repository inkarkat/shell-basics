#!/usr/bin/env bats

load fixture

@test "search for single line regexp as plain argument" {
    run multilinegrep 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp as plain argument and file separated with --" {
    run multilinegrep 'one-l..e' -- "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp as --regexp argument" {
    run multilinegrep --regexp 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep --regexp 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp as --regexp argument and file separated with --" {
    run multilinegrep --regexp 'one-l..e' -- "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep --regexp 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp with multiple matches" {
    run multilinegrep '[Oo]ne' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
Ones here
one-two" ]
    [ "$(grep '[Oo]ne' "$INPUT")" = "$output" ]
}

@test "search for single line regexp with no matches returns 1" {
    run multilinegrep 'doesN.tMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    [ "$(grep 'doesN.tMatch' "$INPUT")" = "$output" ]
}

@test "search for single line regexp that matches the entire line" {
    run multilinegrep 'just one-l..e here' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep 'just one-l..e here' "$INPUT")" = "$output" ]
}

@test "search for two-line regexp with branches" {
    run multilinegrep $'two\|three\n.*l' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "two/lines
three l..es
two
else
two
else
three
the last" ]
}

@test "search for three-line regexp with inner matches" {
    run multilinegrep $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line regexp as block match" {
    run multilinegrep --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line regexp that matches the entire line" {
    run multilinegrep $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line regexp with multiple matches" {
    run multilinegrep $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
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

@test "search for three-line regexp with no matches returns 1" {
    run multilinegrep $'does\nN.t\nMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line regexp with second line not matching returns 1" {
    run multilinegrep $'one-l..e.*\nthre\+.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line regexp with last line not matching returns 1" {
    run multilinegrep $'one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
