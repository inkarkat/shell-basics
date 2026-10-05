#!/usr/bin/env bats

load fixture

@test "commandName --no-interpreter --eval lookup" {
    typeset -A data=(
	[/usr/local/bin/absoluteCommand]='absoluteCommand'
	[. simpleBashScript.sh -x foo]='simpleBashScript.sh'
	[source simpleBashScript.sh -x foo]='simpleBashScript.sh'
	[nohup simpleBashScript.sh -x foo]='simpleBashScript.sh'
	[nohup --version simpleBashScript.sh -x foo]='--version'
	[env FOO=BAR HEY=HO simpleCommandName -x -y -z]='simpleCommandName'
	[sudo simpleCommandName -x -y -z]='simpleCommandName'
	[sudo --login --user=public simpleCommandName -x -y -z]='simpleCommandName'
	[sudo --login --user=public FOO=BAR HEY=HO simpleCommandName -x -y -z]='simpleCommandName'
	[sudo.exe simpleCommandName -x -y -z]='simpleCommandName'
	[perl simplePerlScript.py]='simplePerlScript.py'
	[python3 /usr/local/bin/absolutePythonScript.py -x foo]='absolutePythonScript.py'
	[python3 ${BATS_TEST_DIRNAME}/fixture.bash -x foo]='fixture.bash'
	[sh simpleScript.sh -x foo]='simpleScript.sh'
	["sh -c 'simpleScript.sh -x foo'"]='simpleScript.sh'
	["ksh -ic simpleScript.ksh"]='simpleScript.ksh'
	["bash -c 'perl script.pl'"]='script.pl'
	['bash -c "$@" bash perl script.pl']='script.pl'
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --no-include-files --no-include-subcommands --no-interpreter --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}
