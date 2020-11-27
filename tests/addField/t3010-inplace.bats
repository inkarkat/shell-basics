#!/usr/bin/env bats

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE"
}

@test "adding fox after second and number of fields after last field in-place modifies the input file" {
    run addField --in-place -F $'\t' 2 '"fox"' 4 'NF' "$FILE"

    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1" ]
}

@test "adding fox after second and number of fields after last field in-place modifies the input file and writes a backup" {
    run addField --in-place=.bak -F $'\t' 2 '"fox"' 4 'NF' "$FILE"

    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1" ]

    [ -e "${FILE}.bak" ]
    cmp -- "${BATS_TEST_DIRNAME}/tabbed.txt" "${FILE}.bak"
}
