#!/usr/bin/env bats

stdinAddField()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | fieldMap "$@"
}

@test "concatenating fox to second and number of fields to last field from stdin" {
    run stdinAddField -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr NF'

    [ $status -eq 0 ]
    [ "$output" = "foo	firstfox	100	A Here4
bar	no4fox	201	3
	fox		4
bzz	fox		last4
	fox		2
eof	fox		2" ]
}
