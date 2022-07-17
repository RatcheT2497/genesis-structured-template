#!/bin/bash
while inotifywait -e modify ./src; do
    make
done
