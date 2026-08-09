#!/usr/bin/env bats

load fixture

@test "convert pathname glob to glob" {
    while IFS=$'\t' read -r inputGlob expectedGlob description
    do
	run -0 pathnameGlobToGlob -- "$inputGlob" \
	    && assert_output "$expectedGlob" \
	    || fail "$inputGlob - $description"
    done <<'EOF'
foobar	foobar	string with no glob characters
/foo/bar	/foo/bar	filespec with no glob characters
/f??/bar	/f??/bar	filespec with ? globs
/f*/bar	/f*([^/])/bar	filespec with * glob
/f**/bar	/f*([^/])/bar	filespec with inapplicable f** glob
/foo/**r	/foo/*([^/])r	filespec with inapplicable **r glob
/foo/**/bar	/foo?(/*/)bar	filespec with inner ** glob
**/bar	?(*/)bar	filespec with leading ** glob
/foo/bar/**	/foo/bar/*	filespec with trailing ** glob
EOF
}

@test "handle escapes" {
    while IFS=$'\t' read -r inputGlob expectedGlob description
    do
	run -0 pathnameGlobToGlob -- "$inputGlob" \
	    && assert_output "$expectedGlob" \
	    || fail "$inputGlob - $description"
    done <<'EOF'
foo\bar	foo\bar	escaped plain character
foo\\bar	foo\\bar	double backslash
/f\?\?/bar	/f\?\?/bar	escaped ? glob
/f\*/bar	/f\*/bar	escaped * glob
/f\*\*/bar	/f\*\*/bar	filespec with escaped inapplicable f** glob
/foo/\*\*r	/foo/\*\*r	filespec with escaped inapplicable **r glob
/foo/\*\*/bar	/foo/\*\*/bar	filespec with escaped inner ** glob
\*\*/bar	\*\*/bar	filespec with escaped leading ** glob
/foo/bar/\*\*	/foo/bar/\*\*	filespec with escaped trailing ** glob
/foo/\**/bar	/foo/\**([^/])/bar	filespec with escaped * + * glob
/foo/*\*/bar	/foo/*([^/])\*/bar	filespec with * glob + escaped *
EOF
}
