#!/usr/bin/env bats

load fixture

@test "search for single entire line regexp as plain argument" {
    run multilinegrep --line-regexp 'just one-l..e here' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single entire line regexp as --regexp argument" {
    run multilinegrep --line-regexp --regexp 'just one-l..e here' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
}

@test "search for single entire line regexp with multiple matches" {
    run multilinegrep --line-regexp '[Oo]ne.*[eo]' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "Ones here
one-two" ]
}

@test "search for single entire line regexp with no matches returns 1" {
    run multilinegrep --line-regexp 'one-l..e' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for two-line entire line regexp with branches" {
    run multilinegrep --line-regexp $'two\|three\n.*l.*' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "two
else
two
else
three
the last" ]
}

@test "search for three-line regexp with inner matches" {
    run multilinegrep --line-regexp $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line regexp as block match" {
    run multilinegrep --line-regexp --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for three-line regexp that matches the entire line" {
    run multilinegrep --line-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for entire three-line regexp as plain argument" {
    run multilinegrep --line-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l..es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for entire three-line regexp as --regexp argument" {
    run multilinegrep --line-regexp --regexp $'just one-l..e here\ntwo/l..es\nthre\+ l..es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for entire three-line regexp with multiple matches" {
    run multilinegrep --line-regexp $'[Oo]ne.*\nt.*\n.*l...\{0,1\}' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "Ones here
two
else
one-two
three
the last" ]
}

@test "search for entire three-line regexp with no matches returns 1" {
    run multilinegrep --line-regexp $'one-line.*\ntwo/lines\nthre\+' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for entire three-line regexp with second line not matching returns 1" {
    run multilinegrep --line-regexp $'just one-l..e.*\nthre\+.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for entire three-line regexp with last line not matching returns 1" {
    run multilinegrep --line-regexp $'just one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
