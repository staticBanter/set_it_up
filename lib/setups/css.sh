#!/bin/bash

function setup_css()
{

    if [ ! -d "./css" ]; then
        mkdir "./css"
    fi

    > "./css/$project_name.css"

}
