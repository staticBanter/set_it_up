#!/bin/bash

function checkOptions(){

    while getopts ":hvd" option; do

        case $option in
            h|help)
                help;;
            v|version)
                echo "0.1.10"
                ;;
            d|dry)
                this_option_external_files=false
                this_option_package_files=false
                ;;
            \?)
                echo "Error: Invalid option passed... bailing..."
                exit;;
        esac

    done

}
