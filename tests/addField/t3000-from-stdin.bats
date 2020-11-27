#!/usr/bin/env bats

stdinAddField()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | addField "$@"
}

@test "adding fox after second and number of fields after last field from stdin" {
    run stdinAddField -F $'\t' 2 '"fox"' 4 'NF'

    [ $status -eq 0 ]
    [ "$output" = "foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1" ]
}
