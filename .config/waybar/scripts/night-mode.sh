#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    killall -9 hyprsunset
else
    # Corrección: quitamos la '/' extra y agregamos '&' al final
    hyprsunset --temperature 4800 > /dev/null 2>&1 &
fi
