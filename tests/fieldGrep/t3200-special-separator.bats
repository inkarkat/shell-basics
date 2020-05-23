#!/usr/bin/env bats

@test "grep the second and second-to-last fields with dash separators" {
    run dashFieldGrep --regexp n 2 -2
    [ $status -eq 0 ]
    [ "$output" = "my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops" ]
}
dashFieldGrep()
{
    (cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF
    ) | fieldGrep -F - "$@"
}

@test "grep the first and last fields with double space separators" {
    run doubleSpaceFieldGrep --regexp n 1 -1
    [ $status -eq 0 ]
    [ "$output" = "my bonnie  is over  the endless sea
our hound  can jump  the many hoops" ]
}
doubleSpaceFieldGrep()
{
    (cat <<'EOF'
the fox  jumps over  the lazy dog
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF
    ) | fieldGrep -F '  ' "$@"
}
