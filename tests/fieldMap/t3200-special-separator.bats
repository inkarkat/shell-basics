#!/usr/bin/env bats

@test "concatenating fox to second and number of fields to last field with dash separators" {
    run dashAddField 2 '$fieldNr "fox"' 4 '$fieldNr NF'

    [ $status -eq 0 ]
    [ "$output" = "the-foxfox-jumps-over7-the-lazy-dog
my-fox-is-over7-the--sea
our-houndfox-can-jump7-the-many-hoops" ]
}
dashAddField()
{
    (cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF
    ) | fieldMap -F - "$@"
}

@test "concatenating fox to second and number of fields to last field with double space separators" {
    run doubleSpaceAddField 2 '$fieldNr "fox"' 4 '$fieldNr NF'

    [ $status -eq 0 ]
    [ "$output" = "the fox  jumps overfox  the lazy dog  3
  is overfox    3
our hound  can jumpfox  the many hoops  3" ]
}
doubleSpaceAddField()
{
    (cat <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF
    ) | fieldMap -F '  ' "$@"
}
