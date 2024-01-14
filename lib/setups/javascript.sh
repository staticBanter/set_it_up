#!/bin/bash

setup_javascript()
{

    if [ ! -e "./js/$project_name.js" ]; then

        mkdir "./js"

        cd "./js"

        > "$project_name.js"

        cd "../"

    fi
}
