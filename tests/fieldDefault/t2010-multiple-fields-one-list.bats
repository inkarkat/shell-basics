#!/usr/bin/env bats

@test "defaulting a LIST of first, second fields" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1,2

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz	DEFAULT		last
DEFAULT
eof	DEFAULT" ]
}

@test "defaulting a LIST of first - second fields" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1-2

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz	DEFAULT		last
DEFAULT
eof	DEFAULT" ]
}

@test "defaulting a LIST of second, fourth field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2,4

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34		DEFAULT
buu	empty3		and more
	empty1	606	here
	empty13		also
	DEFAULT		
bzz	DEFAULT		last
	DEFAULT
eof	DEFAULT" ]
}

@test "defaulting third, first field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 3,1

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34	DEFAULT
buu	empty3	DEFAULT	and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz		DEFAULT	last
DEFAULT
eof		DEFAULT" ]
}

@test "defaulting second - fourth field" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2-4

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34	DEFAULT
buu	empty3	DEFAULT	and more
	empty1	606	here
	empty13	DEFAULT	also
	DEFAULT		
bzz	DEFAULT		last
	DEFAULT
eof	DEFAULT" ]
}

@test "default first empty from third field on" {
    run fieldDefault --input <(cat <<'EOF'
one	two	three	four	five	six	seven
one		three	four	five		seven
one	two	three	four			seven
one	two	three		five		seven
one				five	six	seven
one	two	three				seven
EOF
) -F $'\t' --value DEFAULT 3-

    [ $status -eq 0 ]
    [ "$output" = "one	two	three	four	five	six	seven
one		three	four	five	DEFAULT	seven
one	two	three	four	DEFAULT		seven
one	two	three	DEFAULT	five		seven
one		DEFAULT		five	six	seven
one	two	three	DEFAULT			seven" ]
}

@test "default first empty from fifth field from behind on" {
    run fieldDefault --input <(cat <<'EOF'
one	two	three	four	five	six	seven
one		three	four	five		seven
one	two	three	four			seven
one	two	three		five		seven
one				five	six	seven
one	two	three				seven
EOF
) -F $'\t' --value DEFAULT -5-

    [ $status -eq 0 ]
    [ "$output" = "one	two	three	four	five	six	seven
one		three	four	five	DEFAULT	seven
one	two	three	four	DEFAULT		seven
one	two	three	DEFAULT	five		seven
one		DEFAULT		five	six	seven
one	two	three	DEFAULT			seven" ]
}
