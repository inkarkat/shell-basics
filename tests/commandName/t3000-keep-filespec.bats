#!/usr/bin/env bats

load fixture

@test "commandName --keep-filespec --eval lookup" {
    typeset -A data=(
	[simpleCommandName -x -y -z]='simpleCommandName'
	[./simpleCommandName -x -y -z]='./simpleCommandName'
	[/usr/bin/perl simplePerlScript.py]='/usr/bin/perl'
	[../../python3 simplePythonScript.py -x foo]='../../python3'
	[/usr/local/bin/absoluteCommand]='/usr/local/bin/absoluteCommand'
	[/usr/local/bin/absoluteCommand --version]='/usr/local/bin/absoluteCommand'
	[cd /etc; /usr/local/bin/absoluteCommand -x -y -z]='/usr/local/bin/absoluteCommand'
	[! ~/bin/simpleCommandName]="${HOME}/bin/simpleCommandName"
    )

    for commandLine in "${!data[@]}"
    do
	run -0 commandName --keep-filespec --no-include-files --no-include-subcommands --eval "$commandLine" \
	    && assert_output "${data["$commandLine"]}" \
	    || fail "$commandLine should yield ${data["$commandLine"]}"
    done
}
