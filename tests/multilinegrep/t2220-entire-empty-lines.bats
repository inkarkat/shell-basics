#!/usr/bin/env bats

load fixture

@test "search for three-line entire line regexp ending with empty line only matches the empty line" {
    run -0 multilinegrep --line-regexp $'two\nelse\n' "$INPUT"
    assert_output $'two\nelse'
}

@test "search for three-line entire line regexp with empty middle line only matches the empty line" {
    run -0 multilinegrep --line-regexp $'.*o.*\n\nthree' "$INPUT"
    assert_output - <<'EOF'
four+more

three
EOF
}

@test "search for three-line entire line regexp with empty starting line only matches the empty line" {
    run -0 multilinegrep --line-regexp $'\nthree\n.*' "$INPUT"
    assert_output - <<'EOF'

three
with
EOF
}

@test "entire line search for two empty middle lines only matches the empty lines" {
    run -0 multilinegrep --line-regexp $'[^ ]\+\n\n\n[^ ]\+' "$INPUT"
    assert_output - <<'EOF'
else

empty


or
EOF
}
