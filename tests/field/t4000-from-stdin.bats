#!/usr/bin/env bats

stdinField()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | field "$@"
}

@test "print the first field from stdin" {
    run stdinField -F $'\t' 1
    [ $status -eq 0 ]
    [ "$output" = "foo
bar
baz" ]
}

@test "print everything but the first field from stdin" {
    run stdinField -F $'\t' --remove 1
    [ $status -eq 0 ]
    [ "$output" = "first	100	A Here
second	201	B There
third	333	C U" ]
}
