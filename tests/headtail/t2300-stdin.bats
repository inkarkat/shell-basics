#!/usr/bin/env bats

@test "list 2 first and 2 last lines from standard input" {
    run headtail --lines 2 < <(cat "${BATS_TEST_DIRNAME}/counts")
    [ $status -eq 0 ]
    [ "$output" = "one
two
four
five" ]
}

@test "list 2 first and 2 last lines from standard input with verbose" {
    run headtail --verbose --lines 2 < <(cat "${BATS_TEST_DIRNAME}/counts")
    [ $status -eq 0 ]
    [ "$output" = "==> standard input <==
one
two
four
five" ]
}

@test "list 2 first and 2 last lines from standard input specified as -" {
    run headtail --lines 2 - < <(cat "${BATS_TEST_DIRNAME}/counts")
    [ $status -eq 0 ]
    [ "$output" = "one
two
four
five" ]
}

@test "list 2 first and 2 last lines from two files and standard input in between as -" {
    run headtail --verbose --lines 2 "${BATS_TEST_DIRNAME}/counts" - "${BATS_TEST_DIRNAME}/louds" < <(echo foo)
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
one
two
four
five

==> standard input <==
foo

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
TWO
ELEVEN
TWELVE" ]
}

