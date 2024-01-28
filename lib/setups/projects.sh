#!/bin/bash

setup_projects()
{

    case $projectType in

        "VanillaJS") setup_project_vanillajs;;
        "Webpack") setup_project_webpack;;
        "ViteJS") setup_project_vitejs;;
        *) echo "Currently Unsupported Project Type..." exit;;

    esac

    if [[ "${project_requires_npm}" != "n" || "${project_requires_npm}" != "N" ]]; then
        sed -i s/" \&\& \","/"\","/ "./package.json"
    fi

}
