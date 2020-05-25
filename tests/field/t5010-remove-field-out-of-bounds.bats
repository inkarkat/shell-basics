#!/usr/bin/env bats

@test "removing field number 0 removes nothing and prints all fields" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 0
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")" ]
}

@test "removing too large positive field (by one) is ignored" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 5 4
    [ $status -eq 0 ]
    [ "$output" = "first	100
second	201
third	333" ]
}

@test "removing too large positive field (by many) is ignored" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 10 4
    [ $status -eq 0 ]
    [ "$output" = "first	100
second	201
third	333" ]
}

@test "removing too large negative field (by one) is ignored" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 -5 4
    [ $status -eq 0 ]
    [ "$output" = "first	100
second	201
third	333" ]
}

@test "removing too large negative field (by many) is ignored" {
skip
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 -10 4
    [ "$output" = "first	100
second	201
third	333" ]
}
