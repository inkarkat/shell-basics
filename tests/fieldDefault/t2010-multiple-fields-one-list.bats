#!/usr/bin/env bats

@test "defaulting a LIST of first, second fields" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1,2

    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT	DEFAULT		
bzz	DEFAULT		last
DEFAULT	DEFAULT
eof	DEFAULT" ]
}

@test "defaulting a LIST of first - second fields" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1-2

    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT	DEFAULT		
bzz	DEFAULT		last
DEFAULT	DEFAULT
eof	DEFAULT" ]
}

@test "defaulting a LIST of second, fourth field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2,4

    [ "$output" = "foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34		DEFAULT
buu	empty3		and more
	empty1	606	here
	empty13		also
	DEFAULT		DEFAULT
bzz	DEFAULT		last
	DEFAULT		DEFAULT
eof	DEFAULT		DEFAULT" ]
}

@test "defaulting third, first field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 3,1

    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34	DEFAULT
buu	empty3	DEFAULT	and more
DEFAULT	empty1	606	here
DEFAULT	empty13	DEFAULT	also
DEFAULT		DEFAULT	
bzz		DEFAULT	last
DEFAULT		DEFAULT
eof		DEFAULT" ]
}

@test "defaulting second - fourth field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2-4

    [ "$output" = "foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34	DEFAULT	DEFAULT
buu	empty3	DEFAULT	and more
	empty1	606	here
	empty13	DEFAULT	also
	DEFAULT	DEFAULT	DEFAULT
bzz	DEFAULT	DEFAULT	last
	DEFAULT	DEFAULT	DEFAULT
eof	DEFAULT	DEFAULT	DEFAULT" ]
}
