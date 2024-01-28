#!/bin/bash

setup_project_vanillajs()
{

    setup_git

    setup_readme

    setup_licensing

    setup_npm

    setup_javascript

    setup_typescript

    if [[ "${project_requires_npm}" != "n" || "${project_requires_npm}" != "N" ]]; then

        setup_docTools

        setup_testTools

    fi

    setup_frontEnd

}
