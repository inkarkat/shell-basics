#!/usr/bin/env bats

@test "sequence all use custom and different argument separators" {
    run joinWith \
	    --repeat-sequence R + - = ' ' R \
	    --begin-sequence BEGIN '*' ':' ' ' BEGIN \
	    --end-sequence - '. ' ' and ' ' or ' - \
	    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
    [ $status -eq 0 ]
    [ "$output" = "1*2:3 4+5-6=7 8+9-10=11 12+13-14=15. 16 and 17 or 18" ]
}
