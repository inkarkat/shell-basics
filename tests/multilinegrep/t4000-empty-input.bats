#!/usr/bin/env bats

load fixture

requireIfne()
{
    type -t ifne >/dev/null || skip "ifne is not available"
}

setup() {
    EMPTY="${BATS_TMPDIR}/empty"
    : > "$EMPTY"
}

@test "search for single line regexp with no matches in empty input returns 1" {
    run -1 multilinegrep --basic-regexp '.' "$EMPTY"
    assert_output ''
}

@test "search for single line regexp with no matches in null device returns 1" {
    requireIfne
    run -1 multilinegrep --basic-regexp '.' /dev/null
    assert_output ''
}

@test "search for single line regexp with no matches in empty inputs returns 1" {
    requireIfne
    run -1 multilinegrep --basic-regexp '.' "$EMPTY" /dev/null "$EMPTY" /dev/null
    assert_output ''
}

@test "search for explicitly passed three-line regexp with no matches in empty input returns 1" {
    run -1 multilinegrep --basic-regexp $'does\nN.t\nMatch' "$EMPTY"
    assert_output ''
}

@test "search for single line regexp in existing and empty file returns matched line" {
    run -0 multilinegrep --basic-regexp 'Start' "$EMPTY" "$INPUT"
    assert_output 'Start'
}

@test "search for single line regexp in existing and null device returns matched line" {
    run -0 multilinegrep --basic-regexp 'Start' /dev/null "$INPUT"
    assert_output 'Start'
}
