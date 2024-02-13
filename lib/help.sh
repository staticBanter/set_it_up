#!/bin/bash

function help(){

    echo "
        setITup project help. Below are a list of options that can be passed to the script.

        Syntax: set-it-up -option optionValue ...

        Options:
        -h | -help : Print this help command.
        -d | -dry : Runs the script but will not download external files or files from package-managers.
        -v | -version : Print software version and exit.
    "

    exit;

}
