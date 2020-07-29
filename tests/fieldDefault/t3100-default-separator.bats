#!/usr/bin/env bats

@test "default the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run defaultFieldGrep --value X 2 -2

    [ $status -eq 0 ]
    [ "$output" = "the fox jumps over the lazy dog
my X    X
our hound can jump the many hoops" ]
}
defaultFieldGrep()
{
    (cat <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    ) | fieldDefault "$@"
}

@test "default the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run firstTabFieldGrep --value X 2 -2

    [ $status -eq 0 ]
    [ "$output" = "the	fox	jumps	over	the	lazy	dog
my	X				X
our	hound	can	jump	the	many	hoops" ]
}
firstTabFieldGrep()
{
    (cat <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    ) | fieldDefault "$@"
}
