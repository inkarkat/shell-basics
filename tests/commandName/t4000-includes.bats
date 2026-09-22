#!/usr/bin/env bats

load fixture

@test "commandName --eval lookup including subcommands" {
    typeset -A data=(
	[simpleCommandName]='simpleCommandName'
	[simpleCommandName -x -y -z]='simpleCommandName'
	[simpleCommandName sub-command]='simpleCommandName sub-command'
	[simpleCommandName sub1 sub2 -x -y]='simpleCommandName sub1 sub2'
	[simpleCommandName sub1 sub2 sub3 sub4]='simpleCommandName sub1 sub2 sub3 ...'
	[simplePerlScript.py]='simplePerlScript.py'
	[simplePythonScript.py -x foo]='simplePythonScript.py'
	[/usr/local/bin/absoluteCommand sub]='absoluteCommand sub'
	[cd /etc && simpleCommandName -x foo -y bar -z quux]='simpleCommandName'
	[! simpleCommandName sub]='simpleCommandName sub'
	[VAR=VAL simpleCommandName -x -y -z]='simpleCommandName'
	[VAR1=VAL1 VAR2=VAL2 simpleCommandName sub -x -y -z]='simpleCommandName sub'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-interpreter --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}

@test "commandName --eval lookup including custom number of subcommands" {
    typeset -A data=(
	[simpleCommandName]='simpleCommandName'
	[simpleCommandName -x -y -z]='simpleCommandName'
	[simpleCommandName sub-command]='simpleCommandName sub-command'
	[simpleCommandName sub1 sub2 -x -y]='simpleCommandName sub1 ...'
	[simpleCommandName sub1 sub2 sub3 sub4]='simpleCommandName sub1 ...'
	[simplePerlScript.py]='simplePerlScript.py'
	[simplePythonScript.py -x foo]='simplePythonScript.py'
	[/usr/local/bin/absoluteCommand sub]='absoluteCommand sub'
	[cd /etc && simpleCommandName -x foo -y bar -z quux]='simpleCommandName'
	[! simpleCommandName sub]='simpleCommandName sub'
	[VAR=VAL simpleCommandName -x -y -z]='simpleCommandName'
	[VAR1=VAL1 VAR2=VAL2 simpleCommandName sub -x -y -z]='simpleCommandName sub'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-interpreter --include-subcommands 1 --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}

@test "commandName --eval lookup including files" {
    [ -e /etc/hosts ] || skip 'test requires /etc/hosts to exist'
    [ -e /etc/passwd ] || skip 'test requires /etc/passwd to exist'

    typeset -A data=(
	[simpleCommandName]='simpleCommandName'
	[simpleCommandName /etc/hosts]='simpleCommandName /etc/hosts'
	[simpleCommandName /etc/hosts /etc/passwd]='simpleCommandName /etc/hosts ...'
	[simpleCommandName /etc/hosts /doesNotExist /etc/passwd]='simpleCommandName /etc/hosts'
	[simpleCommandName /bin /etc /etc/hosts /etc/passwd]='simpleCommandName /bin ...'
	[simpleCommandName -x -y -z /etc/hosts]='simpleCommandName'
	[simpleCommandName -x /etc/hosts -y /etc/passwd -z /etc /bin]='simpleCommandName'

	[simpleCommandName -x -y -z -- /etc/hosts]='simpleCommandName /etc/hosts'
	[simpleCommandName -x -y -z -- /doesNotExist]='simpleCommandName /doesNotExist'
	[simpleCommandName -x -y -z -- a b c d e f]='simpleCommandName a ...'

	[perl simplePerlScript.py /etc/hosts]='simplePerlScript.py /etc/hosts'
	[python3 simplePythonScript.py -x foo -- /etc]='simplePythonScript.py /etc'
	[/usr/local/bin/absoluteCommand /etc/hosts]='absoluteCommand /etc/hosts'
	[! simpleCommandName /etc/hosts]='simpleCommandName /etc/hosts'
	[VAR=VAL simpleCommandName -x -y -z]='simpleCommandName'
	[VAR1=VAL1 VAR2=VAL2 simpleCommandName /etc/hosts -x -y -z]='simpleCommandName /etc/hosts'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-interpreter --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}

@test "commandName --eval lookup including custom number of files" {
    [ -e /etc/hosts ] || skip 'test requires /etc/hosts to exist'
    [ -e /etc/passwd ] || skip 'test requires /etc/passwd to exist'

    typeset -A data=(
	[simpleCommandName]='simpleCommandName'
	[simpleCommandName /etc/hosts]='simpleCommandName /etc/hosts'
	[simpleCommandName /etc/hosts /etc/passwd]='simpleCommandName /etc/hosts /etc/passwd'
	[simpleCommandName /etc/hosts /doesNotExist /etc/passwd]='simpleCommandName /etc/hosts'
	[simpleCommandName /bin /etc /etc/hosts /etc/passwd]='simpleCommandName /bin /etc /etc/hosts ...'
	[simpleCommandName -x -y -z /etc/hosts]='simpleCommandName'
	[simpleCommandName -x /etc/hosts -y /etc/passwd -z /etc /bin]='simpleCommandName'

	[simpleCommandName -x -y -z -- /etc/hosts]='simpleCommandName /etc/hosts'
	[simpleCommandName -x -y -z -- /doesNotExist]='simpleCommandName /doesNotExist'
	[simpleCommandName -x -y -z -- a b c d e f]='simpleCommandName a b c ...'

	[perl simplePerlScript.py /etc/hosts]='simplePerlScript.py /etc/hosts'
	[python3 simplePythonScript.py -x foo -- /etc]='simplePythonScript.py /etc'
	[/usr/local/bin/absoluteCommand /etc/hosts]='absoluteCommand /etc/hosts'
	[! simpleCommandName /etc/hosts]='simpleCommandName /etc/hosts'
	[VAR=VAL simpleCommandName -x -y -z]='simpleCommandName'
	[VAR1=VAL1 VAR2=VAL2 simpleCommandName /etc/hosts -x -y -z]='simpleCommandName /etc/hosts'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-interpreter --include-files 3 --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}

@test "commandName --eval lookup including subcommands and files" {
    [ -e /etc/hosts ] || skip 'test requires /etc/hosts to exist'
    [ -e /etc/passwd ] || skip 'test requires /etc/passwd to exist'

    typeset -A data=(
	[simpleCommandName]='simpleCommandName'
	[simpleCommandName sub-command /etc/hosts]='simpleCommandName sub-command /etc/hosts'
	[simpleCommandName /etc/hosts sub-command]='simpleCommandName /etc/hosts'
	[simpleCommandName sub1 sub2 sub3 sub4 /bin /etc /etc/hosts /etc/passwd]='simpleCommandName sub1 sub2 sub3 ... /bin ...'
	[simpleCommandName -x sub -y /etc/passwd -z /etc /bin]='simpleCommandName'

	[simpleCommandName sub -x -y -z -- /etc/hosts]='simpleCommandName sub /etc/hosts'
	[simpleCommandName sub -x -y -z -- /doesNotExist]='simpleCommandName sub /doesNotExist'
	[simpleCommandName sub1 sub2 sub3 sub4 -x -y -z -- a b c d e f]='simpleCommandName sub1 sub2 sub3 ... a ...'

	[perl simplePerlScript.py sub /etc/hosts]='simplePerlScript.py sub /etc/hosts'
	[perl simplePerlScript.py sub1 sub2 sub3 sub4 /etc/hosts]='simplePerlScript.py sub1 sub2 sub3 ... /etc/hosts'
	[python3 simplePythonScript.py sub -x foo -- /etc]='simplePythonScript.py sub /etc'
	[/usr/local/bin/absoluteCommand sub-command more-here /etc/hosts]='absoluteCommand sub-command more-here /etc/hosts'
	[! simpleCommandName sub /etc/hosts]='simpleCommandName sub /etc/hosts'
	[VAR1=VAL1 VAR2=VAL2 simpleCommandName sub -x -y -z -- /etc/hosts]='simpleCommandName sub /etc/hosts'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-interpreter --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}
