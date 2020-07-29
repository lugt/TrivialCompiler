#!/bin/sh

QEMU="timeout -v 60 qemu-arm"

set -v
rm -rf "$3"

# run program with QEMU
if [ -e "$2" ]; then
    $QEMU "$1" < "$2" > "$3"
else
    $QEMU "$1" > "$3"
fi

res=$?

if [ -z "$(tail -c 1 "$3")" ]
then
    # newline at eof
    echo "${res}" >> "$3"
else
    # no newline at eof
    echo -n "\n${res}" >> "$3"
fi

diff -w -B -u "$3" "$4"

