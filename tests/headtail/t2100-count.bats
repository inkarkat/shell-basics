#!/usr/bin/env bats

@test "list 2 first and 2 last lines from file" {
    run headtail --lines 2 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "one
two
four
five" ]
}

@test "list 1 first and 1 last lines from file" {
    run headtail --lines 1 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "one
five" ]
}

@test "list 3 first and 3 last lines which is more than file has" {
    run headtail --lines 3 "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/counts")" ]
}
