#!/usr/bin/env bats

load fixture


@test "commandName lookup" {
    run -0 commandName simpleCommandName -x -y -z
    assert_output 'simpleCommandName'

    run -0 commandName VAR1=VAL1 VAR2=VAL2 /usr/bin/python3 simplePythonScript.py -x -y -z
    assert_output 'python3'
}

@test "commandName --eval lookup" {
    typeset -A data=(
	[simpleCommandName]='simpleCommandName'
	[simpleCommandName -x -y -z]='simpleCommandName'
	[perl simplePerlScript.py]='perl'
	[python3 simplePythonScript.py -x foo]='python3'
	[/usr/local/bin/absoluteCommand]='absoluteCommand'
	[/usr/local/bin/absoluteCommand --version]='absoluteCommand'
	[cd /etc && simpleCommandName -x -y -z]='simpleCommandName'
	[cd /etc; /usr/local/bin/absoluteCommand -x -y -z]='absoluteCommand'
	[! simpleCommandName]='simpleCommandName'
	[VAR=VAL simpleCommandName -x -y -z]='simpleCommandName'
	[VAR1=VAL1 VAR2=VAL2 simpleCommandName -x -y -z]='simpleCommandName'
	['VAR1=VAL1 VAR2=multi\ word VAR3= simpleCommandName -x -y -z']='simpleCommandName'
	["VAR1=VAL1 VAR2=\$'spaced\\tand newlined\\nvariable' VAR3='' simpleCommandName -x -y -z"]='simpleCommandName'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}
