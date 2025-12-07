#!/usr/bin/env bats

load fixture

@test "joining lines from stdin" {
    run -0 joinWith --default-separator ', ' <<'EOF'
foo

bar
baz
EOF
    assert_output 'foo, , bar, baz'
}

@test "joining lines from stdin omitting empty lines" {
    run -0 joinWith --default-separator ', ' --omit-empty <<'EOF'

foo


bar

baz
EOF
    assert_output 'foo, bar, baz'
}
