#!/bin/bash

# Max safe value for bash integer arithmetic (due to 64-bit signed int)
MAX_N=92

if [ -z "$1" ]; then
    echo "Usage: fibo <n>"
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: argument should be a positive number."
    exit 1
fi

if [ "$1" -gt "$MAX_N" ]; then
    echo "Error: max value is $MAX_N."
    exit 1
fi

a=1
b=2
n=$1

for (( i=0; i<n; i++ )); do
    echo -n "$a "
    fn=$((a + b))
    a=$b
    b=$fn
done

echo
