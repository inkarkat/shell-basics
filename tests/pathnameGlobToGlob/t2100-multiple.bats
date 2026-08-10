#!/usr/bin/env bats

load fixture

@test "convert empty pathname glob" {
    run -0 pathnameGlobToGlob -- ''
    assert_output ''
}

@test "convert multiple pathname globs to globs" {
    run -0 pathnameGlobToGlob -- 'foo/bar' '' 'foo/*/bar' 'foo/**/bar'
    assert_output - <<'EOF'
foo/bar

foo/*([^/])/bar
foo/?(*/)bar
EOF
}
