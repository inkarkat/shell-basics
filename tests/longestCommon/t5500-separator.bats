#!/usr/bin/env bats

load fixture

@test "custom # separator prefix of two input lines" {
    runWithInput $'#path#to#fo/o\n#path#to#fo/rbidden#bar' longestCommon --get-prefix --separator \#
    [ $status -eq 0 ]
    [ "$output" = "#path#to" ]
}

@test "custom backslash separator prefix of two input lines" {
    runWithInput $'\\path\\to\\foo\n\\path\\to\\forbidden\\bar' longestCommon --get-prefix --separator \\
    [ $status -eq 0 ]
    [ "$output" = '\path\to' ]
}

@test "custom space separator prefix of two input lines" {
    runWithInput $' path to foo\n path to forbidden bar' longestCommon --get-prefix --separator ' '
    [ $status -eq 0 ]
    [ "$output" = " path to" ]
}

@test "custom tab separator prefix of two input lines" {
    runWithInput $'\tpath\tto\tfoo\n\tpath\tto\tforbidden\tbar' longestCommon --get-prefix --separator $'\t'
    [ $status -eq 0 ]
    [ "$output" = $'\tpath\tto' ]
}


@test "custom # separator suffix of two input lines" {
    runWithInput $'#etc#kell/og#foo#bar\n#var#l/og#foo#bar' longestCommon --get-suffix --separator \#
    [ $status -eq 0 ]
    [ "$output" = "foo#bar" ]
}

@test "custom backslash separator suffix of two input lines" {
    runWithInput $'\\etc\\kellog\\foo\\bar\n\\var\\log\\foo\\bar' longestCommon --get-suffix --separator \\
    [ $status -eq 0 ]
    [ "$output" = 'foo\bar' ]
}

@test "custom space separator suffix of two input lines" {
    runWithInput $' etc kellog foo bar\n var log foo bar' longestCommon --get-suffix --separator ' '
    [ $status -eq 0 ]
    [ "$output" = 'foo bar' ]
}

@test "custom tab separator suffix of two input lines" {
    runWithInput $'\tetc\tkellog\tfoo\tbar\n\tvar\tlog\tfoo\tbar' longestCommon --get-suffix --separator $'\t'
    [ $status -eq 0 ]
    [ "$output" = $'foo\tbar' ]
}


@test "custom # separator both of two input lines" {
    runWithInput $'#opt#etc#kell/og#foo#bar\n#opt#var#l/og#foo#bar' longestCommon --get-both --separator \#
    [ $status -eq 0 ]
    [ "$output" = "#opt
foo#bar" ]
}

@test "custom backslash separator both of two input lines" {
    runWithInput $'\\opt\\etc\\kellog\\foo\\bar\n\\opt\\var\\log\\foo\\bar' longestCommon --get-both --separator \\
    [ $status -eq 0 ]
    [ "$output" = '\opt
foo\bar' ]
}

@test "custom space separator both of two input lines" {
    runWithInput $' opt etc kellog foo bar\n opt var log foo bar' longestCommon --get-both --separator ' '
    [ $status -eq 0 ]
    [ "$output" = " opt
foo bar" ]
}

@test "custom tab separator both of two input lines" {
    runWithInput $'\topt\tetc\tkellog\tfoo\tbar\n\topt\tvar\tlog\tfoo\tbar' longestCommon --get-both --separator $'\t'
    [ $status -eq 0 ]
    [ "$output" = $'\topt
foo\tbar' ]
}
