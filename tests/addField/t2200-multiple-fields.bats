#!/usr/bin/env bats

@test "adding fox after second and fun after fourth field" {
    run addField -F $'\t' 2 '"fox"' 4 '"fun"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	fox	100	A Here	fun
bar	no4	fox	201		fun
		fox			fun
bzz		fox		last	fun
		fox			fun
eof		fox			fun" ]
}

@test "adding fox after second and number of fields after last field" {
    run addField -F $'\t' 2 '"fox"' 4 'NF' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1" ]
}

@test "adding X, Y, Z all after the same second field only considers X (the first)" {
    run addField -F $'\t' 2 '"X"' 2 '"Y"' 2 '"Z"'  "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	X	100	A Here
bar	no4	X	201
		X		
bzz		X		last
		X
eof		X" ]
}

@test "adding X, Z both after the same second field and Y after the second-to-last field ignores Z and prefers X over Y in case of overlap" {
    run addField -F $'\t' 2 '"X"' -2 '"Y"' 2 '"Z"'  "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	X	100	Y	A Here
bar	no4	X	201
		X		Y	
bzz		X		Y	last
		X
Y	eof		X" ]
}
