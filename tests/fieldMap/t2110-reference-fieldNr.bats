#!/usr/bin/env bats

@test "duplicating the second field by referencing fieldNr" {
    run fieldMap -F $'\t' 2 '$fieldNr $fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	firstfirst	100	A Here
bar	no4no4	201
			
bzz			last
	
eof	" ]
}

@test "duplicating the last field by referencing fieldNr" {
    run fieldMap -F $'\t' -1 '$fieldNr $fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A HereA Here
bar	no4	201201
			
bzz			lastlast

eofeof" ]
}
