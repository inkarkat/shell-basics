#!/usr/bin/env bats

@test "grep field 0 with generic pattern yields nothing" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . 0
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "grep too large positive field (by one) with generic pattern yields nothing" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . 5
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "grep too large positive field (by many) with generic pattern yields nothing" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . 10
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "grep too large negative field (by one) with generic pattern yields nothing" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -5
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "grep too large negative field (by many) with generic pattern yields nothing" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -10
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
