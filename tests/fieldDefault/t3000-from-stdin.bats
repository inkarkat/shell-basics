#!/usr/bin/env bats

stdinFieldDefault()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | fieldDefault "$@"
}

@test "grep the first field with fixed text from stdin yields one line" {
    run stdinFieldDefault -F $'\t' --value DEFAULT 1

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
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
