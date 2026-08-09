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

@test "handle character classes" {
    while IFS=$'\t' read -r inputGlob expectedGlob description
    do
	run -0 pathnameGlobToGlob -- "$inputGlob" \
	    && assert_output "$expectedGlob" \
	    || fail "$inputGlob - $description"
    done <<'EOF'
*[]*	*([^/])[]*([^/])	no character class
foob[aeiou]r	foob[aeiou]r	plain character class
foob[aeiou	foob[aeiou	plain unclosed character class
foob[^&*#	foob[^&*([^/])#	unclosed character class with *
foob[^&?#]r	foob[^&?#]r	character class with ?
foob[^&*#]r	foob[^&*#]r	character class with *
foob[^&**#]r	foob[^&**#]r	(strange) character class with **
foob[^&/**/#]r	foob[^&/**/#]r	(strange) character class with /**/
foob[]^&*#]r	foob[]^&*#]r	character class starting with ] with *
foob[^]^&*#]r	foob[^]^&*#]r	^-inverted character class starting with ] with *
foob[!]^&*#]r	foob[!]^&*#]r	!-inverted character class starting with ] with *
EOF
}

@test "handle extended globs" {
    while IFS=$'\t' read -r inputGlob expectedGlob description
    do
	run -0 pathnameGlobToGlob -- "$inputGlob" \
	    && assert_output "$expectedGlob" \
	    || fail "$inputGlob - $description"
    done <<'EOF'
foo?(bar)	foo?(bar)	plain extended ?-glob
foo*(bar)	foo*(bar)	plain extended *-glob
foo**(bar)	foo*([^/])*(bar)	* glob followed by plain extended *-glob
foo*(b?r|q*x)	foo*(b?r|q*([^/])x)	extended *-glob containing *
foo*(b[aeiou]r)	foo*(b[aeiou]r)	plain extended *-glob with character class
foo*(b[^&?#)]r)	foo*(b[^&?#)]r)	plain extended *-glob with character class containing )
foo@(bar|f+([Oo]*(a|iz)))	foo@(bar|f+([Oo]*(a|iz)))	nested +-glob and *-glob inside @-glob
EOF
}

@test "convert pathname glob to glob within extended glob does not apply globstar inside" {
    while IFS=$'\t' read -r inputGlob expectedGlob description
    do
	run -0 pathnameGlobToGlob -- "$inputGlob" \
	    && assert_output "$expectedGlob" \
	    || fail "$inputGlob - $description"
    done <<'EOF'
@(/foo/**/bar)	@(/foo/*([^/])/bar)	filespec with inner ** glob only matches a single path component
@(**/bar)	@(*([^/])/bar)	filespec with leading ** glob only matches a single path component
@(/foo/bar/**)	@(/foo/bar/*([^/]))	filespec with trailing ** glob only matches a single path component
**/@(/foo/**/bar)	?(*/)@(/foo/*([^/])/bar)	leading ** glob + filespec with inner ** glob only matches a single path component
@(/foo/**/bar)/**	@(/foo/*([^/])/bar)/*	trailing ** glob + filespec with inner ** glob only matches a single path component
@(/blah|/f*/bar)	@(/blah|/f*([^/])/bar)	filespec alternatives with * glob
@(/blah|/f**/bar)	@(/blah|/f*([^/])/bar)	filespec alternatives with inapplicable f** glob
@(/blah|/foo/**r)	@(/blah|/foo/*([^/])r)	filespec alternatives with inapplicable **r glob
@(/blah|/foo/**/bar)	@(/blah|/foo/*([^/])/bar)	filespec alternatives with inner ** glob also only matches a single path component
@(/blah|**/bar)	@(/blah|*([^/])/bar)	filespec alternatives with leading ** glob also only matches a single path component
@(/blah|/foo/bar/**)	@(/blah|/foo/bar/*([^/]))	filespec alternatives with trailing ** glob also only matches a single path component
foo?(b[^&?#)]r)/**/lala	foo?(b[^&?#)]r)?(/*/)lala	plain extended ?-glob with character class containing ) only matches a single path component but translates a following **
foo?(b[^&?#)]r/**/lala)	foo?(b[^&?#)]r/*([^/])/lala)	plain extended ?-glob with character class containing ) only matches a single path component, also for a following ** inside the extended glob
EOF
}
