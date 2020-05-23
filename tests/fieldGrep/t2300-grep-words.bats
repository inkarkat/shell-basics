#!/usr/bin/env bats

@test "grep whole words in the last field" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --ignore-case --word-regexp --regexp here -1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here" ]
}
