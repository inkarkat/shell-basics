#!/usr/bin/env bats

@test "grep the first and second fields with basic regexp" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --basic-regexp --regexp 'oo\+' --regexp '^.\{5\}$' 1 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
third		333	C U" ]
}

@test "grep the first and second fields with extended regexp" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --extended-regexp --regexp 'oo+' --regexp '^.{5}$' 1 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
third		333	C U" ]
}

@test "grep the first and second fields with Perl regexp" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --perl-regexp --regexp 'oo+|^.{5}$' 1 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
third		333	C U" ]
}
