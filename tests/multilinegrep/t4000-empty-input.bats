#!/usr/bin/env bats

load fixture

setup() {
    EMPTY="${BATS_TMPDIR}/empty"
    > "$EMPTY"
}

@test "search for single line regexp with no matches in empty input returns 1" {
    run multilinegrep --basic-regexp '.' "$EMPTY"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for single line regexp with no matches in null device returns 1" {
    run multilinegrep --basic-regexp '.' /dev/null
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for single line regexp with no matches in empty inputs returns 1" {
    run multilinegrep --basic-regexp '.' "$EMPTY" /dev/null "$EMPTY" /dev/null
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for explicitly passed three-line regexp with no matches in empty input returns 1" {
    run multilinegrep --basic-regexp $'does\nN.t\nMatch' "$EMPTY"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "search for single line regexp in existing and empty file returns matched line" {
    run multilinegrep --basic-regexp 'Start' "$EMPTY" "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "Start" ]
}

@test "search for single line regexp in existing and null device returns matched line" {
    run multilinegrep --basic-regexp 'Start' /dev/null "$INPUT"
    [ $status -eq 0 ]
    [ "$output" = "Start" ]
}
