#!/usr/bin/env bats

load fixture

@test "commandName --full-filespec --eval lookup" {
    typeset -A data=(
	[commandName -x -y -z]='commandName'
	[perl simplePerlScript.py]='perl'
	[python3 simplePythonScript.py -x foo]='python3'
	[cd /etc; commandName -x -y -z]='commandName'
    )

    for commandLine in "${!data[@]}"
    do
	local expected="$(command -v "${data["$commandLine"]}")"
	run -0 commandName --full-filespec --eval "$commandLine" \
	    && assert_output "$expected" \
	    || fail "$commandLine should yield $expected"
    done
}

@test "commandName --full-filespec of an absolute path returns that" {
    local expected="$(command -v commandName)"
    run -0 commandName --full-filespec "$expected" -x -y
    assert_output "$expected"
}

@test "commandName --full-filespec of a relative path returns that" {
    cd "$BATS_TEST_DIRNAME" || fail
    local expected='../../bin/commandName'
    run -0 commandName --full-filespec "$expected" -x -y
    assert_output "$expected"
}

@test "commandName --full-filespec of a non-existing command exits with 1" {
    run -1 commandName --full-filespec doesNotExist -x -y
    assert_output ''
}

@test "commandName --full-filespec of a non-existing command returns the passed UNDEFINED value" {
    run -0 commandName --full-filespec --undefined 'NOT-HERE' doesNotExist -x -y
    assert_output 'NOT-HERE'
}
