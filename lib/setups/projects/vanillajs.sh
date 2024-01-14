#!/bin/bash

setup_project_vanillajs()
{

    setup_readme

    requires_git=""

    read -p "Will you be using Git for version control? (Y/n)" requires_git

    if [ "${requires_git}" != "n" ]; then
        setup_git
    fi

    requires_npm=""

    read -p "Would you like to initialize NPM? (Y/n)" requires_npm

    if [ "${requires_npm}" != "n" ]; then
        setup_npm
    fi

    setup_javascript

    requires_typescript=""

    read -p "Will you be using TypeScript for this project? (Y/n)" requires_typescript

    if [ "${requires_typescript}" != "n" ]; then
        setup_typescript
    fi

    if [ "${requires_npm}" != "n" ]; then

        requires_docTools=""

        read -p "Will you be using any assistive code documentation tooling? (Y/n)" requires_docTools

        if [ "${requires_docTools}" != "n" ]; then
            setup_docTools
        fi

        requires_testTools=""

        read -p "Will you using Test Driven Development or requirer testing tools for your project? (Y/n)" requires_testingTools

        if [ "${requires_testingTools}" != "n" ]; then
            setup_testTools
        fi

    fi

    requires_frontEnd=""

    read -p "Will your program have a front end user interface or be a web-application? (Y/n)"

    if [ "${requires_frontEnd}" != "n" ]; then

        if [ "${requires_npm}" != "n" ]; then

            requires_sass=""

            read -p "Would you like to use SASS/SCSS? (Y/n)" requires_sass

            if [ "${requires_sass}" != "n" ]; then
                setup_sass
            fi

        else
            setup_css
        fi

        setup_frontEnd

    fi

    if [ "${requires_npm}" != "n" ]; then
        if [ -e "./package.json" ]; then
            sed -i s/" \&\& \","/"\","/ "./package.json"
        fi
    fi

}
