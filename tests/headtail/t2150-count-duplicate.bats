#!/usr/bin/env bats

@test "list 2 first and 2 last lines from file, no duplication necessary" {
    run headtail --lines 2 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "one
two
four
five" ]
}

@test "list 3 first and 3 last lines with duplication" {
    run headtail --lines 3 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "one
two
three
three
four
five" ]
}

@test "list 5 first and 5 last lines with duplication" {
    run headtail --lines 5 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "one
two
three
four
five
one
two
three
four
five" ]
}

@test "list 7 first and 7 last lines with duplication and truncation to 5" {
    run headtail --lines 7 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    [ $status -eq 0 ]
    [ "$output" = "one
two
three
four
five
one
two
three
four
five" ]
}
