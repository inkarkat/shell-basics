#!/usr/bin/env bats

@test "default the second and second-to-last fields with dash separators" {
    run dashFieldDefault --value X 2 -2

    [ $status -eq 0 ]
    [ "$output" = "the-fox-jumps-over-the-lazy-dog
my-X-is-over-the-X-sea
our-hound-can-jump-the-many-hoops" ]
}
dashFieldDefault()
{
    (cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF
    ) | fieldDefault -F - "$@"
}

@test "default the first and last fields with double space separators" {
    run doubleSpaceFieldDefault --value X 1 -1

    [ $status -eq 0 ]
    [ "$output" = "the fox  jumps over  the lazy dog
X  is over  X
our hound  can jump  the many hoops" ]
}
doubleSpaceFieldDefault()
{
    (cat <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF
    ) | fieldDefault -F '  ' "$@"
}
