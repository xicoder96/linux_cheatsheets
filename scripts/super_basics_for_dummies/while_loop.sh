#!/bin/bash

# Print all odd numbers between 1-99
X=1
while [ $X -le 99 ]
do
    if [ $(($X%2)) != 0 ] ; then
        echo $X
    fi
    X=$(($X+1))
done