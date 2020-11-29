#!/usr/bin/env bats

@test "turning first field to 0" {
    run fieldMap -F $'\t' 1 0 "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "0	first	100	A Here
0	no4	201
0			
0			last
0
0" ]
}

@test "turning second field to fox" {
    run fieldMap -F $'\t' 2 '"fox"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	fox	100	A Here
bar	fox	201
	fox		
bzz	fox		last
	fox
eof	fox" ]
}

@test "making second field empty" {
    run fieldMap -F $'\t' 2 '""' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo		100	A Here
bar		201
			
bzz			last
	
eof	" ]
}

@test "duplicating first field" {
    run fieldMap -F $'\t' 1 '$1 $1' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foofoo	first	100	A Here
barbar	no4	201
			
bzzbzz			last

eofeof" ]
}

@test "replacing third field with concatenation of first two fields" {
    run fieldMap -F $'\t' 3 '$1 $2' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	foofirst	A Here
bar	no4	barno4
			
bzz		bzz	last
		
eof		eof" ]
}

@test "adding line length as non-existing sixth field" {
    run fieldMap -F $'\t' 6 'length($0)' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here		20
bar	no4	201			11
					3
bzz			last		10
					0
eof					3" ]
}
