#!/usr/bin/env bats

@test "defaulting with various strange values" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value $'\t' 1 --value 'foo bar' 2 --value '' 3 --value $'two\tmore' 4

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201	two	more
baz	empty4	301	two	more
boo	no34		two	more
buu	empty3		and more
		empty1	606	here
		empty13		also
		foo bar		two	more
bzz	foo bar		last
		foo bar		two	more
eof	foo bar		two	more" ]
}
