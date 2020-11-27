#!/usr/bin/env bats

@test "adding 42 after last field" {
    run addField -F $'\t' -1 42 "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	42
bar	no4	201	42
				42
bzz			last	42
42
eof	42" ]
}


@test "adding X after second-to-last field" {
    run addField -F $'\t' -2 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	X	A Here
bar	no4	X	201
			X	
bzz			X	last
X
X	eof" ]
}

