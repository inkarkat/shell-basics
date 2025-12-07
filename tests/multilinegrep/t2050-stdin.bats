#!/usr/bin/env bats

load fixture

@test "search for three-line regexp with multiple matches in stdin" {
    run -0 multilinegrep $'[Oo]ne.*\nt.*\n.*l' <(cat -- "$INPUT")
    assert_output - <<'EOF'
just one-line here
two/lines
three l..es
Ones here
two
else
one-two
three
the last
EOF
}
