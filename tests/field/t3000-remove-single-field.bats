#!/usr/bin/env bats

@test "print everything but the first field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1
    [ $status -eq 0 ]
    [ "$output" = "first	100	A Here
second	201	B There
third	333	C U" ]
}

@test "print everything but the last field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove -1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100
bar	second	201
baz	third	333" ]
}

@test "print everything but the second from last field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove -2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	A Here
bar	second	B There
baz	third	C U" ]
}
