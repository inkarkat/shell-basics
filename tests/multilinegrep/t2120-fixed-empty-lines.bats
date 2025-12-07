#!/usr/bin/env bats

load fixture

@test "search for three-line literal string ending with empty line matches anything for the empty line" {
    run -0 multilinegrep --fixed-strings $'two\nelse\n' "$INPUT"
    assert_output $'two\nelse\ntwo\nelse'
}

@test "search for three-line literal string with empty middle line matches anything for the empty line" {
    run -0 multilinegrep --fixed-strings $'o\n\nthree' "$INPUT"
    assert_output - <<'EOF'
just one-line here
two/lines
three l..es
four+more

three
EOF
}

@test "search for three-line literal string with empty starting line matches anything for the empty line" {
    run -0 multilinegrep --fixed-strings $'\nthree\nwith' "$INPUT"
    assert_output - <<'EOF'
four+more

three
with
EOF
}

@test "literal search for two empty middle lines matches anything for the empty lines" {
    run -0 multilinegrep --fixed-strings $'empty\n\n\nor' "$INPUT"
    assert_output - <<'EOF'
empty


or
EOF
}
