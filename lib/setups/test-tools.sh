#!/bin/bash

setup_testTools()
{

    npm install --save-dev mocha chai c8

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
