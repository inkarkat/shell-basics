#!/usr/bin/env bats

@test "print the first field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1
    [ $status -eq 0 ]
    [ "$output" = "foo
bar
baz" ]
}

@test "print the last field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -1
    [ $status -eq 0 ]
    [ "$output" = "A Here
B There
C U" ]
}

@test "print the second from last field" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -2
    [ $status -eq 0 ]
    [ "$output" = "100
201
333" ]
}
