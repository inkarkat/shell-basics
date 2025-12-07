#!/usr/bin/env bats

load fixture

@test "search for three-line block ending with empty line matches anything for the empty line" {
    run -0 multilinegrep --block-regexp $'two\nelse\n' "$INPUT"
    assert_output $'two\nelse\n\ntwo\nelse\none-two'
}

@test "search for three-line block with empty middle line only matches the middle line" {
    run -0 multilinegrep --block-regexp $'o.*\n\nthree' "$INPUT"
    assert_output - <<'EOF'
four+more

three
EOF
}

@test "search for three-line block with empty starting line matches anything for the empty line and last line" {
    run -0 multilinegrep --block-regexp $'\nthree\n.*' "$INPUT"
    assert_output - <<'EOF'

three
with
one-two
three
the last
EOF
}

@test "search for two empty middle lines block matches anything for the empty lines" {
    run -0 multilinegrep --block-regexp $'[^ ]\n\n\n[^ ]' "$INPUT"
    assert_output - <<'EOF'
else

empty


or
EOF
}
