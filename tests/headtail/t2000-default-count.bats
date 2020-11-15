#!/usr/bin/env bats

@test "list 5 first and 5 last lines from file" {
    run headtail "${BATS_TEST_DIRNAME}/louds"
    [ $status -eq 0 ]
    [ "$output" = "ONE
TWO
THREE
FOUR
FIVE
EIGHT
NINE
TEN
ELEVEN
TWELVE" ]
}

@test "list 5 first and 5 last lines from stdin" {
    run headtail < <(cat "${BATS_TEST_DIRNAME}/louds")
    [ $status -eq 0 ]
    [ "$output" = "ONE
TWO
THREE
FOUR
FIVE
EIGHT
NINE
TEN
ELEVEN
TWELVE" ]
}
