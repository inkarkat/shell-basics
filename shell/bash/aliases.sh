#!/bin/bash source-this-script

# The default approach for alias support doesn't work here, but we can still
# leverage the basic function and just modify the final forwarding call. Here,
# instead of injecting the bash invocation of the expanded alias into trace,
# the trace call has to be inside the bash invocation, prepended to just the
# expanded alias.
# trace bash -ic "unset MYLOGO; set +m; cmd=\$1; shift; eval \"\$cmd \\\"\\\$@\\\"\"" bash "${commands[*]}"
#   ↓↓↓
# bash -ic "unset MYLOGO; set +m; cmd=\$1; shift; eval trace \"\$cmd \\\"\\\$@\\\"\"" bash "${commands[*]}"
addAliasSupport trace '' '' '' ''
    unalias tracea  # Need to temporarily remove the alias to be able to modify the function.
	functionmodify -e 's/\(trace "\${traceArgs\[@\]}" "\${dashDash\[@\]}" \)\(bash .* eval \)/\2\1/' tracea
    alias tracea='tracea '
