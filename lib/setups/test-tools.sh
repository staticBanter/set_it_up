#!/bin/bash

setup_testTools()
{



    read -p "Will you using Test Driven Development or requirer testing tools for your project? (Y/n)" project_requires_testingTools

    if [[ "${project_requires_testingTools}" == "n" || "${project_requires_testingTools}" == "N" ]]; then
        return;
    fi

    if [ $this_option_package_files == true ]; then
        npm install --save-dev mocha chai c8
    else
        npm install --save-dev --package-lock-only --no-package-lock mocha chai c8
    fi

    sed -i s/'"test": "echo \\"Error: no test specified\\" && exit 1",'// "./package.json"

    sed -i s/"\"scripts\": {"/"\"scripts\":{\n    \"test\": \"mocha\","/ "./package.json"

    sed -i s/"\"scripts:\" {"/"\"scripts\":{\n    \"coverage\": \"c8 \-\-check\-coverage\=80 mocha\","/ "./package.json"

    sed -i s/"\"production\": \""/"\"production\": \"npm run test \&\& "/ "./package.json"

    if [ ! -d "./test" ]; then

        mkdir "./test"

        > "./test/$project_name.test.js"

    fi

    if [ ! -e "./.mocharc.json" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/.mocharc.json" ]; then
            cp "$this_program_cache_dirPath/project_template_files/.mocharc.json" .
        fi
    fi

    if [ ! -e "./.c8rc.json" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/.c8rc.json" ]; then
            cp "$this_program_cache_dirPath/project_template_files/.c8rc.json" .
        fi
    fi

}
