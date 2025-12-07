#!/usr/bin/env bats

load fixture

@test "search for existing two-line regexp" {
    run -0 multilinegrep --basic-regexp $'just.*\n.' "$INPUT"
    assert_output - <<'EOF'
just one-line here
two/lines
EOF
}

@test "search for two-line regexp where the second line match does not exist" {
    run -1 multilinegrep --basic-regexp $'just.*\nNOT' "$INPUT"
    assert_output ''
}

@test "search for non-existing two-line regexp" {
    run -1 multilinegrep --basic-regexp $'just.*\nNOT' "$INPUT"
    assert_output ''
}

@test "search for two-line regexp where input stops at the first line" {
    run -1 multilinegrep --basic-regexp $'just.*\n.' "$INPUT2"
    assert_output ''
}
