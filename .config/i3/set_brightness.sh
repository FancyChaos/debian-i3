#!/bin/bash
current=$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ')

new=$(echo $current$1 | bc)

for con in $(xrandr | grep " connected" | cut -f1 -d " ")
do
	xrandr --output $con --brightness $new &> /dev/null
done
