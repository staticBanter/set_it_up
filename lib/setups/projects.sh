#!/bin/bash

setup_projects()
{

    case $projectType in
        "VanillaJS") setup_project_vanillajs;;
        "Webpack") setup_project_webpack;;
        *) echo "Currently Unsupported Project Type..." exit;;
    esac

}
