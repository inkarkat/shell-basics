#!/usr/bin/env bats

@test "grep the last two fields with generic pattern yields all lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -2 -1
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")" ]
}

@test "grep the first two fields with fixed text yields one line with just the matching field and an empty one" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --regexp oo 1 2
    [ $status -eq 0 ]
    [ "$output" = "foo		100	A Here" ]
}

@test "grep the first and last fields with fixed text yields the matching fields" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --regexp r 1 -1
    [ $status -eq 0 ]
    [ "$output" = "	first	100	A Here
bar	second	201	B There" ]
}

@test "grep the first and last fields with regexp that matches both fields yields those lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp 'oo$\|^A' 1 -1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here" ]
}
