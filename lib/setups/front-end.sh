#!/bin/bash

setup_frontEnd_framework()
{

    if [ -e "./package.json" ]; then

        includeFrontendFramework=""

        read -p "Would you like to Include a Front-End Framework? (Y/n) " includeFrontendFramework

        if [ "${includeFrontendFramework}" != "n" ]; then

            frontendFrameworks="normalize.css bootstrap tailwindcss"

            select frontendFramework in $frontendFrameworks;
            do

                if [ $this_option_package_files == true ]; then
                    npm install "${frontendFramework}"
                else
                    npm install --save-dev --package-lock-only --no-package-lock "${frontendFramework}"
                fi

                break;
            done

        fi

    fi

    if [ -e "./web/css/$project_name.css" ]; then

        cd "./web/css"

        mv "./$project_name.css" "./main.css"

        cd "../"

        if [ -e "./index.html" ]; then

            sed -i s/"href=\".\/css\/$project_name.css\""/"href\=\".\/css\/main.css\""/ "./index.html"

        fi

        cd "../"

    fi

}

setup_frontEnd()
{

    requires_frontEnd=""

    read -p "Will your program have a Front End User Interface or be a Web-Application? (Y/n)"

    if [[ "${requires_frontEnd}" == "n" ||  "${requires_frontEnd}" == "N" ]]; then
        return;
    fi

    if [[ "${project_requires_npm}" != "n" || "${project_requires_npm}" != "N" ]]; then
        setup_sass
    else
        setup_css
    fi

    read -p "Enter the Monetary Price you will be charging for your project (default: $project_jsonld_default_price): " project_jsonld_price

    if [ "${project_jsonld_price}" == "" ]; then
        project_jsonld_price=$project_jsonld_default_price
    fi

    read -p "Enter the Application Category that your project is made for (default: $project_jsonld_default_category)" project_jsonld_category

    if [ "${project_jsonld_category}" == "" ]; then
        project_jsonld_price=$project_jsonld_default_category
    fi

    read -p "Enter the Compatible Operating Systems your project can support (default: $project_jsonld_default_compatibleSystems)" project_jsonld_compatibleSystems

    if [ "${project_jsonld_compatibleSystems}" == "" ]; then
        project_jsonld_price=$project_jsonld_default_compatibleSystems
    fi

    if [ -e "./package.json" ]; then

        sed -e 1a\ " \  \"browser\": \"web\/js\/$project_name.js\"," -i "./package.json"

        sed -i s/"\"main\": \"js\/set_me_up_project.js\","/"\"main\": \"web\/js\/$project_name.js\","/ "./package.json"

    fi

    directories="web/storage/icons web/storage/screenshots"

    for directory in $directories;
    do

        if [ ! -d "${directory}" ]; then
            mkdir -p $directory
        fi

    done;

    if [ -d "./scss" ]; then

        sed s/"\"sass-build\": \"sass .\/scss\/$project_name.scss:.\/css\/$project_name.css"/"\"sass-build\": \"sass .\/scss\/$project_name.scss:.\/web\/\/prod\/css\/$project_name.css"/  -i  "./package.json"

        sed s/"\"sass-watch\": \"sass .\/scss\/$project_name.scss:.\/css\/$project_name.css"/"\"sass-watch\": \"sass .\/scss\/$project_name.scss:.\/web\/\/prod\/css\/$project_name.css"/ -i "./package.json"

    fi

    if [ -d "./js" ]; then
        mv -n "./js" "./web"
    fi

    if [ -d "./css" ]; then
        mv -n "./css" "./web"
    fi

    if [ -d "./docs/html" ]; then

        publicDocumentation=""

        read -p "Would you like your Documentation to be Public? (Y/n)" publicDocumentation

        if [ "${publicDocumentation}" != "n" ]; then

            mv -n "./docs/html" "./web/docs"

            if [ -e "./jsdoc.config.json" ]; then
                sed -i s/"\"destination\": \".\/docs\/html\","/"\"destination\": \".\/web\/docs\","/ "./jsdoc.config.json"
            fi

        fi

    fi

    cd "./web"

    echo "User-agent: *
Disallow:" > "./robots.txt"

    declare -a templateFiles

    templateFiles="index.html manifest.json"

    for templateFile in $templateFiles;
    do

        if [ ! -e "./$templateFile" ]; then
            if [ -a "$this_program_cache_dirPath/project_template_files/$templateFile" ]; then
                cp "$this_program_cache_dirPath/project_template_files/$templateFile" .
            fi
        fi

        swapTemplateFileVariables $templateFile

    done

    cd "../"

    setup_frontEnd_framework

}
