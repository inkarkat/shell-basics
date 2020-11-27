#!/usr/bin/env bats

@test "adding fox after second and number of fields after last field takes runs of spaces and tabs and outputs with a single space" {
    run defaultAddField 2 '"fox"' 4 'NF'

    [ $status -eq 0 ]
    [ "$output" = "the fox fox jumps over 7 the lazy dog
my  fox   1
our hound fox can jump 7 the many hoops" ]
}
defaultAddField()
{
    (cat <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    ) | addField "$@"
}

@test "adding fox after second and number of fields after last field takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run firstTabAddField 2 '"fox"' 4 'NF'

    [ $status -eq 0 ]
    [ "$output" = "the	fox	fox	jumps	over	7	the	lazy	dog
my		fox			1
our	hound	fox	can	jump	7	the	many	hoops" ]
}
firstTabAddField()
{
    (cat <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    ) | addField "$@"
}
