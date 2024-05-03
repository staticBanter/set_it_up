#!/bin/bash

function optExec(){

    for arg in "$@"; do

        shift

        case "$arg" in

            '--help') set -- "$@" '-h' ;;
            '--dry') set -- "$@" '-d' ;;
            '--version') set -- "$@" '-v' ;;
            *) set -- "$@" "$arg" ;;

        esac

    done

    while getopts ":hvd" opt
    do
        case "$opt" in

            'h')
                help
                exit;
            ;;

            'v')
                version
                exit;
            ;;

            'd')
                this_option_external_files=false
                this_option_package_files=false
            ;;

            '*')
                echo "ERROR: Unsupported Option."
            ;;

        esac
    done

    shift $(expr $OPTIND - 1)

}
