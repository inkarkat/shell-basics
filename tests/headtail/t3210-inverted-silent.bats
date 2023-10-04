#!/usr/bin/env bats

@test "list all but 2 first and 2 last lines from two files with silent" {
    run headtail --silent --lines -2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "three
THREE
FOUR
FIVE
SIX
SEVEN
EIGHT
NINE
TEN" ]
}
