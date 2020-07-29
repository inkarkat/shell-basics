#!/usr/bin/env bats

@test "last field will refer to the passed max field number" {
    run fieldDefault --input <(cat <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one				five
fewer	here
fill
EOF
) -F $'\t' --field-num 3 --value DEFAULT -1

    [ $status -eq 0 ]
    [ "$output" = "one	two	DEFAULT
fill		DEFAULT
one	two	three
fill		DEFAULT
one	two	three	four	five
fill		DEFAULT
one				five
fewer	here	DEFAULT
fill		DEFAULT" ]
}

@test "second-to-last field will refer to the passed max field number unless there are more fields in a line" {
    run fieldDefault --input <(cat <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one				five
fewer	here
fill
EOF
) -F $'\t' --field-num 3 --value DEFAULT -2

    [ $status -eq 0 ]
    [ "$output" = "one	two
fill	DEFAULT
one	two	three
fill	DEFAULT
one	two	three	four	five
fill	DEFAULT
one			DEFAULT	five
fewer	here
fill	DEFAULT" ]
}
