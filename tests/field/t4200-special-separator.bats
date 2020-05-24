#!/usr/bin/env bats

dashField()
{
    (cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF
    ) | field -F - "$@"
}
@test "print the second and second-to-last fields with dash separators" {
    run dashField 2 -2
    [ $status -eq 0 ]
    [ "$output" = "fox-lazy
bonnie-endless
hound-many" ]
}
@test "print everything but the second and second-to-last fields with dash separators" {
    run dashField --remove 2 -2
    [ $status -eq 0 ]
    [ "$output" = "the-jumps-over-the-dog
my-is-over-the-sea
our-can-jump-the-hoops" ]
}

doubleSpaceField()
{
    (cat <<'EOF'
the fox  jumps over  the lazy dog
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF
    ) | field -F '  ' "$@"
}
@test "print the first and last fields with double space separators" {
    run doubleSpaceField 1 -1
    [ $status -eq 0 ]
    [ "$output" = "the fox  the lazy dog
my bonnie  the endless sea
our hound  the many hoops" ]
}
@test "print everything but the first and last fields with double space separators" {
    run doubleSpaceField --remove 1 -1
    [ $status -eq 0 ]
    [ "$output" = "jumps over
is over
can jump" ]
}
