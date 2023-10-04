#!/usr/bin/env bats

@test "list all but the 1 first and 1 last lines from file" {
    run headtail --lines -1 "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "TWO
THREE
FOUR
FIVE
SIX
SEVEN
EIGHT
NINE
TEN
ELEVEN" ]
}

@test "list all but 5 first and 5 last lines from stdin" {
    run headtail --lines -5 < <(cat "${BATS_TEST_DIRNAME}/louds")
    [ $status -eq 0 ]
    [ "$output" = "SIX
SEVEN" ]
}

@test "list all but 2 first and 2 last lines resulting in a single line" {
    run headtail --lines -2 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "three" ]
}

@test "list all but 3 first and 3 last lines which is more than file has" {
    run headtail --lines -3 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "" ]
}
