#!/bin/bash


function copyOrDownloadLicense()
{

    licenseDirectory="$this_program_cache_dirPath/licenses"
    githubLicenseApiUrl="https://api.github.com/licenses"

    if [ ! -e "./LICENSE" ]; then

        if [ ! -d "${licenseDirectory}" ]; then
            mkdir "$licenseDirectory"
        fi

        if [ ! -e "${licenseDirectory}/${project_license}" ]; then

            downloadLicense=""

            read -p "Would you like to download the license type $project_license from $githubLicenseApiUrl. (Y/n) " downloadLicense

            if [ "${downloadLicense}" != "n" ]; then

                curl "$githubLicenseApiUrl/$project_license" | jq -r ".body" > "${licenseDirectory}/${project_license}"

            fi

        fi

        cp "${licenseDirectory}/${project_license}"  "./LICENSE"

        currentYear=$(date --date="now" +%G)

        sed -i "s/\[year\]/$currentYear/ ; s/\[fullname\]/$client_name/" "./LICENSE"

    fi

}

function setup_projectLicensing()
{

    printf "
    Select a License Type.
    If you would like to have an alternative License or No License select the $this_project_customLicenseOption option.
    For a list of alternative Licenses you can visit: https://spdx.org/licenses
    Note: If your license is not present in the selection you must provide a copy the license.
    "
    select selected_license in $this_project_licenses;
    do

        project_license=$selected_license

        if [ "${project_license}" == "${this_project_customLicenseOption}" ]; then

            read -p "
            Enter an alternative license your alternative license must match a license in the SPDX License List Identifier column.
            Or leave blank for no license.
            " project_license

        else

            copyOrDownloadLicense

        fi

        break;
    done

}

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

    licensingProject=""

    read -p "Will you be licensing your project? (Y/n)"

    if [ "${licensingProject}" != "n" ]; then
        setup_projectLicensing
    fi

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
