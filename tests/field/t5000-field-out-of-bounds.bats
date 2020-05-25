#!/usr/bin/env bats

@test "field number 0 prints all fields" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 0
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")" ]
}

@test "too large positive field (by one) is treated as empty" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 5 2
    [ $status -eq 0 ]
    [ "$output" = "foo		first
bar		second
baz		third" ]
}

@test "too large positive field (by many) is treated as empty" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 10 2
    [ $status -eq 0 ]
    [ "$output" = "foo		first
bar		second
baz		third" ]
}

@test "too large negative field (by one) is treated as empty" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 -5 2
    [ $status -eq 0 ]
    [ "$output" = "foo		first
bar		second
baz		third" ]
}

@test "too large negative field (by many) is treated as empty" {
skip
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 -10 2
    [ $status -eq 0 ]
    [ "$output" = "foo		first
bar		second
baz		third" ]
}
