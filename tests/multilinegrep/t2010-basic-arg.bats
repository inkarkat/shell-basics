#!/usr/bin/env bats

load fixture

@test "search for explicitly passed single line regexp as plain argument" {
    run multilinegrep --basic-regexp 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep --basic-regexp 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for explicitly passed single line regexp as --regexp argument" {
    run multilinegrep --basic-regexp --regexp 'one-l..e' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here" ]
    [ "$(grep --basic-regexp --regexp 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for explicitly passed single line regexp with multiple matches" {
    run multilinegrep --basic-regexp '[Oo]ne' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "just one-line here
Ones here
one-two" ]
    [ "$(grep --basic-regexp '[Oo]ne' "$INPUT")" = "$output" ]
}

@test "search for explicitly passed single line regexp with no matches returns 1" {
    run multilinegrep --basic-regexp 'doesN.tMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    [ "$(grep --basic-regexp 'doesN.tMatch' "$INPUT")" = "$output" ]
}

@test "search for explicitly passed two-line regexp with branches" {
    run multilinegrep --basic-regexp $'two\|three\n.*l' "$INPUT"
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

@test "search for explicitly passed three-line regexp with inner matches" {
    run multilinegrep --basic-regexp $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for explicitly passed three-line regexp as block match" {
    run multilinegrep --basic-regexp --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for explicitly passed three-line regexp that matches the entire line" {
    run multilinegrep --basic-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = $'just one-line here\ntwo/lines\nthree l..es' ]
}

@test "search for explicitly passed three-line regexp with multiple matches" {
    run multilinegrep --basic-regexp $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
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

@test "search for explicitly passed three-line regexp with no matches returns 1" {
    run multilinegrep --basic-regexp $'does\nN.t\nMatch' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for explicitly passed three-line regexp with second line not matching returns 1" {
    run multilinegrep --basic-regexp $'one-l..e.*\nthre\+.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for explicitly passed three-line regexp with last line not matching returns 1" {
    run multilinegrep --basic-regexp $'one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
