#!/usr/bin/env bats

load fixture

@test "commandName --full-filespec --eval lookup" {
    typeset -A data=(
	[commandName -x -y -z]='commandName'
	[perl simplePerlScript.py]='perl'
	[python3 /usr/local/bin/absolutePythonScript.py -x foo]='python3'
	[cd /etc; commandName -x -y -z]='commandName'
    )

    for commandLine in "${!data[@]}"
    do
	local expected="$(command -v "${data["$commandLine"]}")"
	run -0 commandName --full-filespec --no-include-files --no-include-subcommands --eval "$commandLine" \
	    && assert_output "$expected" \
	    || fail "$commandLine should yield $expected"
    done
}

@test "commandName --no-interpreter --full-filespec --eval lookup" {
    local absoluteCommandName="$(command -v commandName)"
    typeset -A data=(
	[commandName -x -y -z]="$absoluteCommandName"
	[perl commandName]="$absoluteCommandName"
	[python3 ${BATS_TEST_DIRNAME}/fixture.bash -x foo]="${BATS_TEST_DIRNAME}/fixture.bash"
	[cd /etc; commandName -x -y -z]="$absoluteCommandName"
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-interpreter --full-filespec --no-include-files --no-include-subcommands --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}

@test "commandName --full-filespec of an absolute path that is found in PATH returns that" {
    local expected="$(command -v commandName)"
    run -0 commandName --no-interpreter --full-filespec "$expected" -x -y
    assert_output "$expected"
}

@test "commandName --full-filespec of an absolute path not found in PATH returns that" {
    run -0 commandName --no-interpreter --full-filespec "${BATS_TEST_DIRNAME}/fixture.bash" -x -y
    assert_output "${BATS_TEST_DIRNAME}/fixture.bash"
}

@test "commandName --full-filespec of a relative path returns that" {
    cd "$BATS_TEST_DIRNAME" || fail
    local expected='../../bin/commandName'
    run -0 commandName --no-interpreter --full-filespec "$expected" -x -y
    assert_output "$expected"
}

@test "commandName --full-filespec of a non-existing plain command exits with 1" {
    run -1 commandName --no-interpreter --full-filespec doesNotExist -x -y
    assert_output ''
}

@test "commandName --full-filespec of a non-existing absolute command exits with 1" {
    run -1 commandName --no-interpreter --full-filespec /usr/local/bin/doesNotExist -x -y
    assert_output ''
}

@test "commandName --full-filespec of a non-existing command returns the passed UNDEFINED value" {
    run -0 commandName --no-interpreter --full-filespec --undefined 'NOT-HERE' doesNotExist -x -y
    assert_output 'NOT-HERE'
}
