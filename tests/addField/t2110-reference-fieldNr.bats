#!/usr/bin/env bats

@test "duplicating the second field by referencing fieldNr" {
    run addField -F $'\t' 2 '$fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	first	100	A Here
bar	no4	no4	201
				
bzz				last
		
eof		" ]
}

@test "duplicating the last field by referencing fieldNr" {
    run addField -F $'\t' -1 '$fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	A Here
bar	no4	201	201
				
bzz			last	last

eof	eof" ]
}
