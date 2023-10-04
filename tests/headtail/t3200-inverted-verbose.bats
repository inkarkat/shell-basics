#!/usr/bin/env bats

@test "list all but 2 first and 2 last lines from single file with verbose" {
    run headtail --verbose --lines -2 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
three" ]
}

@test "list all but 2 first and 2 last lines from two files is verbose by default" {
    run headtail --verbose --lines -2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
three

==> ${BATS_TEST_DIRNAME}/louds <==
THREE
FOUR
FIVE
SIX
SEVEN
EIGHT
NINE
TEN" ]
}

@test "list all but 0 first and 0 last lines from two files is verbose by default" {
    run headtail --verbose --lines -0 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
$(cat "${BATS_TEST_DIRNAME}/counts")

==> ${BATS_TEST_DIRNAME}/louds <==
$(cat "${BATS_TEST_DIRNAME}/louds")" ]
}

@test "list all but 0 first and 0 last lines from single file with verbose" {
    run headtail --verbose --lines -0 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "==> ${BATS_TEST_DIRNAME}/counts <==
$(cat "${BATS_TEST_DIRNAME}/counts")" ]
}
