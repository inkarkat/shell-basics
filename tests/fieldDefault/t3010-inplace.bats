#!/usr/bin/env bats

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE"
}

@test "grep the first field with fixed text in-place modifies the input file" {
    run fieldDefault --input "$FILE" --in-place -F $'\t' --value DEFAULT 1

    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz			last
DEFAULT
eof" ]
}

@test "grep the first field with fixed text in-place modifies the input file and writes a backup" {
    rm -f -- "${FILE}.bak"
    run fieldDefault --input "$FILE" --in-place=.bak -F $'\t' --value DEFAULT 1

    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz			last
DEFAULT
eof" ]
    
    [ -e "${FILE}.bak" ]
    cmp -- "${BATS_TEST_DIRNAME}/tabbed.txt" "${FILE}.bak"
}
