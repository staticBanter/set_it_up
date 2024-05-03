#!/bin/bash

version(){

    if [ ! -e "./VERSION" ]; then

        echo "ERROR: Could not locate Version File..."
        echo "Please review the README for the version of this program."
        return;

    fi

    echo "$(sed '1q;d' "./VERSION")"

}
