#!/bin/bash

setup_npm()
{

    isProjectScoped=""

    read -p "Would you like your project to be scoped? (y/N)" isProjectScoped

    if [[ "${isProjectScoped}" == "y" || "${isProjectScoped}" == "Y" ]]; then

        hasCustomScope=""

        read -p "Do you have a custom NPM Scope? (y/N)" hasCustomScope

        if [[ "${hasCustomScope}" == "y" || "${hasCustomScope}" == "Y" ]]; then
            project_scope="@$client_name"
        fi

    fi

    npm init -y --init-author-name "${client_name}" --init-author-url "${client_url}" --init-license "${project_license}" --scope "${project_scope}"

    projectKeywordsIndex=0

    for keyword in $project_keywords; do

        if [ $projectKeywordsIndex == 0 ]; then
            sed -i s/"\"keywords\": \["/"\"keywords\": \[\"$keyword\" "/ "./package.json"
        else
            sed -i s/"\"keywords\": \["/"\"keywords\": \[\"$keyword\", "/ "./package.json"
        fi

        ((projectKeywordsIndex++))

    done

    sed -i s/"\"version\": \"1.0.0\","/"\"version\": \"$project_version\","/ "./package.json"
    sed -i s/"\"description\": \"$project_name \=\""/"\"description\": \"$project_description\""/ "./package.json"
    sed -i s/"\"main\": \"index.js\""/"\"main\": \"js\/$project_name.js\""/ "./package.json"

    sed -i -f "$this_lib_path/sed/package.json.sed.sh" "./package.json"

    if [ ! -e "./.npmignore" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/.npmignore" ]; then
            cp "$this_program_cache_dirPath/project_template_files/.npmignore" .
        fi
    fi

}
