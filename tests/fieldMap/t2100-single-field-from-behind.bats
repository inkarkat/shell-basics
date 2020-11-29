#!/usr/bin/env bats

@test "adding 42 to third field" {
    run fieldMap -F $'\t' 3 '$fieldNr + 42' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	142	A Here
bar	no4	243
		42	
bzz		42	last
		42
eof		42" ]
}

@test "concatenating X to second-to-last field" {
    run fieldMap -F $'\t' -2 '$fieldNr "X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100X	A Here
bar	no4X	201
		X	
bzz		X	last

eof" ]
}

@test "concatenating X after third-to-last field" {
    run fieldMap -F $'\t' -3 '$fieldNr "X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	firstX	100	A Here
barX	no4	201
	X		
bzz	X		last

eof" ]
}
