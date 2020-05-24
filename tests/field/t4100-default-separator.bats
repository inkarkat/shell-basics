#!/usr/bin/env bats

defaultField()
{
    (cat <<'EOF'
the fox	jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
    ) | field "$@"
}
@test "print the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run defaultField 2 -2
    [ $status -eq 0 ]
    [ "$output" = "fox lazy
bonnie endless
hound many" ]
}
@test "print everything but the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run defaultField --remove 2 -2
    [ $status -eq 0 ]
    [ "$output" = "the jumps over the dog
my is over the sea
our can jump the hoops" ]
}

firstTabField()
{
    (cat <<'EOF'
the	fox jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
    ) | field "$@"
}
@test "print the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run firstTabField 2 -2
    [ $status -eq 0 ]
    [ "$output" = "fox	lazy
bonnie	endless
hound	many" ]
}
@test "print everything but the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run firstTabField --remove 2 -2
    [ $status -eq 0 ]
    [ "$output" = "the	jumps	over	the	dog
my	is	over	the	sea
our	can	jump	the	hoops" ]
}
