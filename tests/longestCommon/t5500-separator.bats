#!/usr/bin/env bats

load fixture

@test "custom # separator prefix of two input lines" {
    run -0 longestCommon --get-prefix --separator \# <<'EOF'
#path#to#fo/o
#path#to#fo/rbidden#bar
EOF
    assert_output '#path#to'
}

@test "custom backslash separator prefix of two input lines" {
    run -0 longestCommon --get-prefix --separator \\ <<'EOF'
\path\to\foo
\path\to\forbidden\bar
EOF
    assert_output '\path\to'
}

@test "custom space separator prefix of two input lines" {
    run -0 longestCommon --get-prefix --separator ' ' <<'EOF'
 path to foo
 path to forbidden bar
EOF
    assert_output ' path to'
}

@test "custom tab separator prefix of two input lines" {
    run -0 longestCommon --get-prefix --separator $'\t' <<'EOF'
	path	to	foo
	path	to	forbidden	bar
EOF
    assert_output $'\tpath\tto'
}


@test "custom # separator suffix of two input lines" {
    run -0 longestCommon --get-suffix --separator \# <<'EOF'
#etc#kell/og#foo#bar
#var#l/og#foo#bar
EOF
    assert_output 'foo#bar'
}

@test "custom backslash separator suffix of two input lines" {
    run -0 longestCommon --get-suffix --separator \\ <<'EOF'
\etc\kellog\foo\bar
\var\log\foo\bar
EOF
    assert_output 'foo\bar'
}

@test "custom space separator suffix of two input lines" {
    run -0 longestCommon --get-suffix --separator ' ' <<'EOF'
 etc kellog foo bar
 var log foo bar
EOF
    assert_output 'foo bar'
}

@test "custom tab separator suffix of two input lines" {
    run -0 longestCommon --get-suffix --separator $'\t' <<'EOF'
	etc	kellog	foo	bar
	var	log	foo	bar
EOF
    assert_output $'foo\tbar'
}


@test "custom # separator both of two input lines" {
    run -0 longestCommon --get-both --separator \# <<'EOF'
#opt#etc#kell/og#foo#bar
#opt#var#l/og#foo#bar
EOF
    assert_output - <<'EOF'
#opt
foo#bar
EOF
}

@test "custom backslash separator both of two input lines" {
    run -0 longestCommon --get-both --separator \\ <<'EOF'
\opt\etc\kellog\foo\bar
\opt\var\log\foo\bar
EOF
    assert_output - <<'EOF'
\opt
foo\bar
EOF
}

@test "custom space separator both of two input lines" {
    run -0 longestCommon --get-both --separator ' ' <<'EOF'
 opt etc kellog foo bar
 opt var log foo bar
EOF
    assert_output - <<'EOF'
 opt
foo bar
EOF
}

@test "custom tab separator both of two input lines" {
    run -0 longestCommon --get-both --separator $'\t' <<'EOF'
	opt	etc	kellog	foo	bar
	opt	var	log	foo	bar
EOF
    assert_output $'\topt\nfoo\tbar'
}
