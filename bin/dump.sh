#!/bin/sh
TMPFILE=${TEMP:-/tmp}/$(basename "$0").$$
echo "command-line arguments: $@" > "${TMPFILE}"
echo "command-line arguments \$0: \"$0\"" >> "${TMPFILE}"
let argCnt=1
while [ $# -gt 0 ]
do
    echo "command-line arguments \$${argCnt}: \"$1\"" >> "${TMPFILE}"
    shift
    let argCnt+=1
done
echo "STDIN:" >> "${TMPFILE}"
cat >> "${TMPFILE}"
echo "Dumped contents to \"${TMPFILE}\"."

