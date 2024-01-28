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

function setup_licensing()
{
    licensingProject=""

    read -p "Will you be licensing your project? (Y/n)" licensingProject

    if [[ "${licensingProject}" == "n" || "${licensingProject}" == "N" ]]; then
        return 0;
    fi

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
