#!/bin/bash

setup_docTools()
{
    requires_docTools=""

    read -p "Will you be using any assistive code documentation tooling? (Y/n)" requires_docTools

    if [[ "${requires_docTools}" == "n" || "${requires_docTools}" == "N" ]]; then
        return
    fi

    if [ $this_option_package_files == true ]; then
        npm install --save-dev jsdoc
    else
        npm install --save-dev --package-lock-only --no-package-lock jsdoc
    fi

    if [ ! -e "./jsdoc.config.json" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/jsdoc.config.json" ]; then
            cp "$this_program_cache_dirPath/project_template_files/jsdoc.config.json" .
        fi
    fi

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"docs-build\": \"jsdoc .\/js\/ --tutorials .\/docs --configure .\/jsdoc.config.json\","/ "./package.json"

    sed -i s/"\"production\": \""/"\"production\": \"npm run docs-build \&\& "/ "./package.json"

    customJSDocTemplate=""

    read -p "Will you be using a Custom JSDoc Template? (Y/n)" customJSDocTemplate

    if [ "${customJSDocTemplate}" != "n" ]; then

        jsdocTemplates="default haruki"

        printf "Select a JSDoc Template: \n"

        select jsdocTemplate in $jsdocTemplates
        do

            if [ -d "./node_modules/jsdoc/templates/$jsdocTemplate" ]; then

                mkdir -p "./docs/html"

                cp -r "./node_modules/jsdoc/templates/$jsdocTemplate/" "./docs/template"

                cd "./docs/template"

                echo "{}" > "package.json"

                cd "../../"

            fi

            break;
        done;

        sed -i s/"\"opts\": {"/"\"opts\": {\n   \"template\":\".\/docs\/template\","/ "./jsdoc.config.json"

    fi

}
