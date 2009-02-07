#!/bin/sh
TMPFILE=${TEMP:-/tmp}/$(basename "$0").$$
echo "command-line arguments: $@" > "${TMPFILE}"
echo "command-line arguments \$0: \"$0\"" >> "${TMPFILE}"
echo "command-line arguments \$1: \"$1\"" >> "${TMPFILE}"
echo "command-line arguments \$2: \"$2\"" >> "${TMPFILE}"
echo "command-line arguments \$3: \"$3\"" >> "${TMPFILE}"
echo "command-line arguments \$4: \"$4\"" >> "${TMPFILE}"
echo "command-line arguments \$5: \"$5\"" >> "${TMPFILE}"
echo "STDIN:" >> "${TMPFILE}"
cat >> "${TMPFILE}"
print -R "Dumped contents to \"${TMPFILE}\"."
