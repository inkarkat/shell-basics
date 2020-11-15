#!/usr/bin/env bats

@test "list 2 first and 2 last lines from single file with verbose" {
    run headtail --verbose --lines 2 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
one
two
four
five" ]
}

@test "list 2 first and 2 last lines from two files is verbose by default" {
    run headtail --verbose --lines 2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
one
two
four
five

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
TWO
ELEVEN
TWELVE" ]
}

