#!/usr/bin/env bats

@test "list all but 2 first and 2 last lines from standard input" {
    run headtail --lines -2 < <(cat "${BATS_TEST_DIRNAME}/counts")
    [ $status -eq 0 ]
    [ "$output" = "three" ]
}

@test "list all but 2 first and 2 last lines from standard input with verbose" {
    run headtail --verbose --lines -2 < <(cat "${BATS_TEST_DIRNAME}/counts")
    [ $status -eq 0 ]
    [ "$output" = "==> standard input <==
three" ]
}

@test "list all but 2 first and 2 last lines from standard input specified as -" {
    run headtail --lines -2 - < <(cat "${BATS_TEST_DIRNAME}/counts")
    [ $status -eq 0 ]
    [ "$output" = "three" ]
}
