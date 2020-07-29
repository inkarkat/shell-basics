#!/usr/bin/env bats

@test "defaulting multiple LISTs of first and second fields" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1 2

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

@test "defaulting multiple LISTs of first and second fields with different values" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value ONE 1 --value TWO 2

    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
ONE	empty1	606	here
ONE	empty13		also
ONE	TWO		
bzz	TWO		last
ONE	TWO
eof	TWO" ]
}

@test "defaulting multiple LISTs of disjunct fields with different values is only defaulting the first field of a LIST" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value A 1,3 --value B 2,4

    [ "$output" = "foo	first	100	A Here
bar	no4	201	B
baz	empty4	301	B
boo	no34	A	B
buu	empty3	A	and more
A	empty1	606	here
A	empty13		also
A	B		
bzz	B	A	last
A	B
eof	B	A" ]
}

@test "defaulting multiple single-element LISTs of disjunct fields can be used to default all fields" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value A 1 3 --value B 2 4

    [ "$output" = "foo	first	100	A Here
bar	no4	201	B
baz	empty4	301	B
boo	no34	A	B
buu	empty3	A	and more
A	empty1	606	here
A	empty13	A	also
A	B	A	B
bzz	B	A	last
A	B	A	B
eof	B	A	B" ]
}

@test "defaulting multiple LISTs of overlapping fields with different values gives precedence to previous values" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value A 1-3 --value B 2,4

    [ "$output" = "foo	first	100	A Here
bar	no4	201	B
baz	empty4	301	B
boo	no34	A	B
buu	empty3	A	and more
A	empty1	606	here
A	empty13		also
A	B		
bzz	A		last
A	B
eof	A		B" ]
}
