#!/bin/bash

function setup_projectInformation()
{

    read -p "Enter your project Name (default: $project_default_name): " project_name

    if [ "${project_name}" == "" ]; then
        project_name="$project_default_name"
    fi

    read -p "Enter your projects 'Short Name' (default: $project_default_shortName): " project_shortName

    if [ "${project_shortName}" == "" ]; then
        project_shortName="$project_default_shortName"
    fi

    if [ ! -d "./${project_name}" ]; then
        mkdir "./$project_name"
    fi

    cd "./$project_name"

    read -p "Enter the Locale Language for your project (default: $project_default_locale): " project_locale

    if [ "${project_locale}" == "" ]; then
        project_locale=$project_default_locale
    fi

    read -p "Enter your projects Description: " project_description

    if [ "${project_description}" == "" ]; then
        project_description="$project_default_description"
    fi

    project_description_short=$(echo $project_description | cut -d. -f1).

    read -p "Enter your projects Keywords (default: $project_default_keywords): " project_keywords

    if [ "${project_keywords}" == "" ]; then
        project_keywords="$project_default_keywords"
    fi

    read -p "Enter your projects Version (default: $project_default_version): " project_version

    if [ "${project_version}" == "" ]; then
        project_version=$project_default_version
    fi

    read -p "Enter your projects Theme Colour (default: $project_default_colour): " project_colour

    if [ "${project_colour}" == "" ]; then
        project_colour="$project_default_colour"
    fi

    read -p "Enter your projects Public Facing URL: " project_url

    printf "
    Select Base Project Language your project will be written in:
    "

    select projectLanguage in $this_project_languages
    do
        project_language="${projectLanguage}"
        break;
    done

    printf "
    Select the Type of Project you will be creating:
    "

    select projectType in ${this_project_frameworks["$project_language"]}
    do
        project_type="${projectType}"
        break;
    done

    setup_projects

}
