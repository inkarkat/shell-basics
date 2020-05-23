#!/usr/bin/env bats

@test "grep the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run defaultFieldGrep --regexp n 2 -2
    [ $status -eq 0 ]
    [ "$output" = "my bonnie is over the endless sea
our hound can jump the many hoops" ]
}
defaultFieldGrep()
{
    (cat <<'EOF'
the fox	jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
    ) | fieldGrep "$@"
}

@test "grep the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run firstTabFieldGrep --regexp n 2 -2
    [ $status -eq 0 ]
    [ "$output" = "my	bonnie	is	over	the	endless	sea
our	hound	can	jump	the	many	hoops" ]
}
firstTabFieldGrep()
{
    (cat <<'EOF'
the	fox jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
    ) | fieldGrep "$@"
}
