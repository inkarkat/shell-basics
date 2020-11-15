#!/usr/bin/env bats

@test "list 2 first and 2 last lines from two files with silent" {
    run headtail --silent --lines 2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "one
two
four
five
ONE
TWO
ELEVEN
TWELVE" ]
}
