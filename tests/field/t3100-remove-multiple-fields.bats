#!/usr/bin/env bats

@test "print everything but the first two fields" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 2
    [ $status -eq 0 ]
    [ "$output" = "100	A Here
201	B There
333	C U" ]
}

@test "print everything but the second and last fields" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 2 -1
    [ $status -eq 0 ]
    [ "$output" = "foo	100
bar	201
baz	333" ]
}

@test "remove everything but the second field prints just the second field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 3 4
    [ $status -eq 0 ]
    [ "$output" = "first
second
third" ]
}

@test "removing all fields prints nothing" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 4 3 2 1
    [ $status -eq 0 ]
    [ "$output" = "" ]
}
