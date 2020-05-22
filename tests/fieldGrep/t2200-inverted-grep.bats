#!/usr/bin/env bats

@test "grep the last field with inverted pattern that does not match yields all lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp doesNotMatch -1
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")" ]
}

@test "grep the first field with inverted fixed text yields one line" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --invert-match --regexp ba 1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here" ]
}

@test "grep the second from last field with an inverted text-only regexp yields two lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp 3 -2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	second	201	B There" ]
}

@test "grep the second field with a regexp yields two lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -v --regexp '^......$' 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
baz	third	333	C U" ]
}

@test "grep the last field with an inverted generic pattern yields nothing and exits with 1" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp . -1
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "grep the first field with inverted fixed text that also matches in other columns yields two lines with incomplete fields" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --fixed-strings --regexp r 1
    [ $status -eq 0 ]
    [ "$output" = "foo		100
baz		333	C U" ]
}

@test "grep the first field with inverted match that primitively ensures to exclude other columns yields full two lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp '^[^0-9	]\+r' 1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
baz	third	333	C U" ]
}

@test "grep the first field with inverted match that excludes other columns via PCRE yields full two lines" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --perl-regexp --regexp '^(?!\d+\t).*r' 1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
baz	third	333	C U" ]
}
