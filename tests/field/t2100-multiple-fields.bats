#!/usr/bin/env bats

@test "print the first two fields with original separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first
bar	second
baz	third" ]
}

@test "print the second and last fields with original separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 2 -1
    [ $status -eq 0 ]
    [ "$output" = "first	A Here
second	B There
third	C U" ]
}

@test "print all fields in reverse order with original separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 3 2 1
    [ $status -eq 0 ]
    [ "$output" = "A Here	100	first	foo
B There	201	second	bar
C U	333	third	baz" ]
}
