#!/usr/bin/env bats

@test "grep everything but the second field yields the matching fields" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-fields --regexp '[eo]' 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	A Here
	second	B There" ]
}

@test "grep everything but the second and third fields with fixed text yields the matching fields" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-fields --fixed-strings --regexp r 2 3
    [ $status -eq 0 ]
    [ "$output" = "	first	100	A Here
bar	second	201	B There" ]
}
