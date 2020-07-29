#!/usr/bin/env bats

@test "defaulting first field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1

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

@test "defaulting second field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
	empty1	606	here
	empty13		also
	DEFAULT		
bzz	DEFAULT		last
	DEFAULT
eof	DEFAULT" ]
}

@test "defaulting third field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 3

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34	DEFAULT
buu	empty3	DEFAULT	and more
	empty1	606	here
	empty13	DEFAULT	also
		DEFAULT	
bzz		DEFAULT	last
		DEFAULT
eof		DEFAULT" ]
}

@test "defaulting fourth field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 4

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34		DEFAULT
buu	empty3		and more
	empty1	606	here
	empty13		also
			DEFAULT
bzz			last
			DEFAULT
eof			DEFAULT" ]
}

@test "defaulting non-existing fifth field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 5

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
	empty1	606	here
	empty13		also
			
bzz			last

eof" ]
}
