#!/bin/bash

cd `readlink -f $0 | grep -o '.*/'`

VARS_FILE=playbook-vars.yml
for f in $VARS_FILE private/$VARS_FILE samples/$VARS_FILE; do
    if [[ -f $f ]]; then
        VARS_FILE=$f
        break
    fi
done

ansible-playbook playbook.yml -e @$VARS_FILE $*
