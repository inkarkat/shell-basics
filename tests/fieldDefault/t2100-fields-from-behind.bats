#!/usr/bin/env bats

@test "last field will refer to the highest field number already seen" {
    run fieldDefault --input <(cat <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
fewer	here
fill
EOF
) -F $'\t' --value DEFAULT -1

    [ $status -eq 0 ]
    [ "$output" = "one	two
fill	DEFAULT
one	two	three
fill		DEFAULT
one	two	three	four	five
fill				DEFAULT
fewer	here			DEFAULT
fill				DEFAULT" ]
}

@test "default first of last three fields" {
    run fieldDefault --input <(cat <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one	two	three	four	five	six	seven
fill
EOF
) -F $'\t' --value DEFAULT -3--1

    [ $status -eq 0 ]
    [ "$output" = "one	two
fill	DEFAULT
one	two	three
fill	DEFAULT
one	two	three	four	five
fill		DEFAULT
one	two	three	four	five	six	seven
fill				DEFAULT" ]
}

@test "default all last three fields" {
    run fieldDefault --input <(cat <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one	two	three	four	five	six	seven
fill
EOF
) -F $'\t' --value DEFAULT -3 -2 -1

    [ $status -eq 0 ]
    [ "$output" = "one	two
fill	DEFAULT
one	two	three
fill	DEFAULT	DEFAULT
one	two	three	four	five
fill		DEFAULT	DEFAULT	DEFAULT
one	two	three	four	five	six	seven
fill				DEFAULT	DEFAULT	DEFAULT" ]
}

@test "default third and second-to-last field" {
    run fieldDefault --input <(cat <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one	two	three	four	five	six	seven
fill
EOF
) -F $'\t' --value FIX 3 --value LAST -2

    [ $status -eq 0 ]
    [ "$output" = "one	two
fill
one	two	three
fill	LAST	FIX
one	two	three	four	five
fill		FIX	LAST
one	two	three	four	five	six	seven
fill		FIX			LAST" ]
}
