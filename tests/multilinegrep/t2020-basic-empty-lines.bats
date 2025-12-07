#!/usr/bin/env bats

load fixture

@test "search for three-line regexp ending with empty line matches anything for the empty line" {
    run -0 multilinegrep $'two\nelse\n' "$INPUT"
    assert_output $'two\nelse\n\ntwo\nelse\none-two'
}

@test "search for three-line regexp with empty middle line matches anything for the empty line" {
    run -0 multilinegrep $'o\n\nthree' "$INPUT"
    assert_output - <<'EOF'
just one-line here
two/lines
three l..es
four+more

three
EOF
}

@test "search for three-line regexp with empty starting line matches anything for the empty line" {
    run -0 multilinegrep $'\nthree\n.*' "$INPUT"
    assert_output - <<'EOF'
two/lines
three l..es
four+more

three
with
one-two
three
the last
EOF
}

@test "search for two empty middle lines matches anything for the empty lines" {
    run -0 multilinegrep $'[^ ]\n\n\n[^ ]' "$INPUT"
    assert_output - <<'EOF'
Start
just one-line here
two/lines
three l..es
four+more

three
with
two
else

empty
or
Ones here
two
else
EOF
}
