#!/bin/bash

while [ $# -ne 0 ]
    do
        if ! grep -q "${1%,}" ${PWD}/*.asm; then
            echo "\033[1;33mExtern: "${1%,}" not found\033[0m"
        fi
        shift
    done
