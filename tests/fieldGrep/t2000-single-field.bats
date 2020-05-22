#!/usr/bin/env bats

@test "grep the last field with generic pattern yields all lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -1
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")" ]
}

@test "grep the first field with fixed text yields one line" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --regexp oo 1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here" ]
}

@test "grep the second from last field with a text-only regexp yields two lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp 0 -2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	second	201	B There" ]
}

@test "grep the second field with a regexp yields two lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp '^.....$' 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
baz	third	333	C U" ]
}

@test "grep the last field with a non-matching pattern yields nothing and exits with 1" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp doesNotMatch -1
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
