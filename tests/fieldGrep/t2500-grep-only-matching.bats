#!/usr/bin/env bats

@test "grep the last field matching only a word" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[Hh]ere' -1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	Here
bar	second	201	here" ]
}

@test "grep the second field matching only vowels; multiple matches in a field will be joined via space" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[aeiou]' 2
    [ $status -eq 0 ]
    [ "$output" = "foo	i	100	A Here
bar	e o	201	B There
baz	i	333	C U" ]
}

@test "grep the first and second fields matching only vowels; multiple matches in a field will be joined via space" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[aeiou]\+' 1 2
    [ $status -eq 0 ]
    [ "$output" = "oo	i	100	A Here
a	e o	201	B There
a	i	333	C U" ]
}

@test "grep the first and second fields Perl-matching only vowels; multiple matches in a field will be joined via space" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --perl-regexp --regexp '[aeiou]+' 1 2
    [ $status -eq 0 ]
    [ "$output" = "oo	i	100	A Here
a	e o	201	B There
a	i	333	C U" ]
}

@test "grep the first and second fields matching only consonants; multiple matches in a field will be joined via space and attributed to the last filtered field" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[^aeiou]\+' 1 2
    [ $status -eq 0 ]
    [ "$output" = "f	f rst	100	A Here
b	r s c nd	201	B There
b	z th rd	333	C U" ]
}
