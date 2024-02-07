#!/bin/bash

setup_npm()
{

    read -p "Would you like to initialize NPM? (Y/n)" project_requires_npm

    if [[ "${project_requires_npm}" == "n" || "${project_requires_npm}" == "N" ]]; then
        return;
    fi

    isProjectScoped=""

    read -p "Would you like your project to be scoped? (y/N)" isProjectScoped

    if [[ "${isProjectScoped}" == "y" || "${isProjectScoped}" == "Y" ]]; then

        customScope=""

        read -p "Enter your NPM repository scope name (default: @$client_name):" customScope

        if [ "${customScope}" == "" ]; then
            customScope="@$client_name"
        fi

        project_scope="${customScope}"

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

    sed -i s/'"scripts": {'/"\"scripts\": {\n    \"production\": \"\",\n    \"prod\": \"npm run production\","/ "./package.json"

    # sed -e 1a\ " \  \}," -i "./package.json"

    sed -e 1a\ " \  \"private\": true," -i "./package.json"

    sed -e 1a\ " \  \"type\": \"module\"," -i "./package.json"

    if [ ! -e "./.npmignore" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/.npmignore" ]; then
            cp "$this_program_cache_dirPath/project_template_files/.npmignore" .
        fi
    fi

}
