#!/bin/bash

setup_vitejs_vanillaJs()
{

    mv "./public/" "./assets/"

    mv "./javascript.svg" "./assets/"

    mkdir "./js/"

    mv "./main.js" "./counter.js" "./js/"

    mkdir "./css/"

    mv "./style.css" "./css"

    sed -i s/"\/main.js"/".\/js\/main.js"/ "./index.html"

    sed -i s/"'.\/style.css'"/"'..\/css\/style.css'"/ "./js/main.js"

    sed -i s/"'.\/javascript.svg'"/"'\/javascript.svg'"/ "./js/main.js"

    if [ ! -e "./vite.config.js" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/vite.config" ]; then
            cp "$this_program_cache_dirPath/project_template_files/vite.config" ./vite.config.js
        fi
    fi


}

setup_vitejs_vanillaTs()
{

    mv "./public/" "./assets/"

    mv "./src/typescript.svg" "./assets/"

    mkdir "./css/"

    mv "./src/style.css" "./css/"

    sed -i s/"'.\/style.css'"/"'..\/css\/style.css'"/ "./src/main.ts"

    sed -i s/"'.\/typescript.svg'"/"'\/typescript.svg'"/ "./src/main.ts"

    if [ ! -e "./vite.config.ts" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/vite.config" ]; then
            cp "$this_program_cache_dirPath/project_template_files/vite.config" ./vite.config.ts
        fi
    fi

}

setup_project_vitejs()
{

    cd "../"

    if [ ! -d "./${project_name}" ]; then

        continue_with_setup=""

        printf "WARING: Lost location of project directory. If you continue a new project directory will be created from this location. Continue (Y/n)?" continue_with_setup

        if [[ "${continue_with_setup}" == "n" || "${continue_with_setup}" == "N" ]]; then

            exit;

        fi

    fi

    viteTemplates="vanilla vanilla-ts"

    printf "Select a Vite Template:\n"

    vite_project_template=$viteTemplate

    select viteTemplate in $viteTemplates
    do

        vite_project_template=$viteTemplate

        npm create vite@latest $project_name -- --template $viteTemplate

        break
    done;

    if [ ! -d "./${project_name}" ]; then

        printf "Bailing on setup. This was most likely due to Vite not creating the project directory."

        exit;

    fi

    cd ./$project_name

    if [ $this_option_package_files == true ]; then
        npm install
    fi

    case $vite_project_template in

        "vanilla") setup_vitejs_vanillaJs;;
        "vanilla-ts") setup_vitejs_vanillaTs;;

    esac

    sed -i s/"\"version\": \"0\.0\.0\""/"\"version\": \"$project_version\""/ "./package.json"

    sed -e 1a\ " \  \"description\": \"$project_description\"," -i "./package.json"

    sed -e 1a\ " \  \}," -i "./package.json"

    sed -e 1a\ " \  \"author\": \{" -i "./package.json"

    sed -i s/'"author": {'/"\"author\": \{\n    \"name\": \"$client_name\""/ "./package.json"

    if [ "${client_email}" != "" ]; then

        sed -i s/'"author": {'/"\"author\": \{\n    \"email\": \"$client_email\","/ "./package.json"

    fi

    if [ "${project_license}" != "" ]; then

        sed -e 1a\ " \  \"license\": \"$project_license\"," -i "./package.json"

    fi

        if [ "${project_keywords}" != "" ]; then

        sed -e 1a\ " \  \]," -i "./package.json"

        sed -e 1a\ " \  \"keywords\": \[" -i "./package.json"

        projectKeywordsIndex=0

        for keyword in $project_keywords;
        do

            if [ $projectKeywordsIndex == 0 ]; then

                sed -i s/"\"keywords\": \["/"\"keywords\": \[\n    \"$keyword\" "/ "./package.json"

            else

                sed -i s/"\"keywords\": \["/"\"keywords\": \[\n    \"$keyword\", "/ "./package.json"

            fi

            ((projectKeywordsIndex++))

        done

    fi

    sed -i s/'"scripts": {'/"\"scripts\": {\n    \"production\": \"\",\n    \"prod\": \"npm run production\","/ "./package.json"

    sed -i s/"\"production\": \""/"\"production\": \"npm run build \&\& "/ "./package.json"

    sed -i s/"\"version\": \"0\.0\.0\""/"\"version\": \"$project_version\""/ "./package-lock.json"

    if [ -e "./.gitignore" ]; then

        rm "./.gitignore"

    fi

    setup_git

    setup_readme

    setup_licensing

    setup_docTools

    setup_testTools

    if [[ "${project_requires_testingTools}" != "n" && "${project_requires_testingTools}" != "N" ]]; then

        if [ -e "./c8rc.json" ]; then

            if [[ "${vite_project_template}" == "vanilla"  ]]; then

                sed -i s/"\"exclude\":\["/"\"exclude\":\[\n  \"web\/\","/ "./c8rc.json"

            fi

        fi

    fi

}
