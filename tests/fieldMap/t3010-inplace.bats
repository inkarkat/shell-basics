#!/usr/bin/env bats

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE"
}

@test "concatenating fox to second and number of fields to last field in-place modifies the input file" {
    run fieldMap --in-place -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr NF' "$FILE"

    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "foo	firstfox	100	A Here4
bar	no4fox	201	3
	fox		4
bzz	fox		last4
	fox		2
eof	fox		2" ]
}

@test "concatenating fox to second and number of fields to last field in-place modifies the input file and writes a backup" {
    run fieldMap --in-place=.bak -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr NF' "$FILE"

    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "foo	firstfox	100	A Here4
bar	no4fox	201	3
	fox		4
bzz	fox		last4
	fox		2
eof	fox		2" ]

    [ -e "${FILE}.bak" ]
    cmp -- "${BATS_TEST_DIRNAME}/tabbed.txt" "${FILE}.bak"
}
