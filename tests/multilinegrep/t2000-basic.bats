#!/usr/bin/env bats

load fixture

@test "search for single line regexp as plain argument" {
    run multilinegrep 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single line regexp as --regexp argument" {
    run multilinegrep --regexp 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single line regexp with multiple matches" {
    run multilinegrep '[Oo]ne' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
Ones here
one-two" ]
}

@test "search for single line regexp with no matches returns 1" {
    run multilinegrep 'doesN.tMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line regexp as plain argument" {
    run multilinegrep $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line regexp as --regexp argument" {
    run multilinegrep --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
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
