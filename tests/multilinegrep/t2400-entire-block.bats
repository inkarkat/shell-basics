#!/usr/bin/env bats

load fixture

@test "search for single line block regexp as plain argument" {
    run multilinegrep --block-regexp 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single line block regexp as --regexp argument" {
    run multilinegrep --block-regexp --regexp 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single line block regexp with multiple matches" {
    run multilinegrep --block-regexp '[Oo]ne' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
Ones here
one-two" ]
}

@test "search for single line block regexp with no matches returns 1" {
    run multilinegrep --block-regexp 'doesN.tMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for single line block regexp that matches the entire line" {
    run multilinegrep --block-regexp 'just one-l..e here' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for two-line block regexp with branches" {
    run multilinegrep --block-regexp $'two\|three\n.*l' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "two
else
two
else
three
the last" ]
}

@test "search for three-line block regexp with inner matches" {
    run multilinegrep --block-regexp $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line block regexp as block match" {
    run multilinegrep --block-regexp --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line block regexp that matches the entire line" {
    run multilinegrep --block-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for three-line block regexp with multiple matches" {
    run multilinegrep --block-regexp $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
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

@test "search for three-line block regexp with no matches returns 1" {
    run multilinegrep --block-regexp $'does\nN.t\nMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line block regexp with second line not matching returns 1" {
    run multilinegrep --block-regexp $'one-l..e.*\nthre\+.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line block regexp with last line not matching returns 1" {
    run multilinegrep --block-regexp $'one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
