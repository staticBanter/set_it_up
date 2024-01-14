#!/bin/bash

function setup_typescript()
{

    if ! command tsc -v &> /dev/null
    then

        npm install --save-dev tsc

        sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"tsc-init\":\"tsc --init\""/ "./package.json"

        npm run tsc --init

        sed -i s/"\"scripts\": {\n    \"tsc-init\":\"tsc --init\""/""/ "./package.json"

    else

        tsc --init

    fi

    sed -i -f "$this_lib_path/sed/tsconfig.sed.sh" "./tsconfig.json"

    if [ -e "./package.json" ]; then
        sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"tsc\": \"tsc --project .\",\n    \"tsc-watch\": \"tsc --watch --project .\","/ "./package.json"
        sed -i s/"\"production\": \""/"\"production\": \"npm run tsc \&\& "/ "./package.json"
    fi

    if [ ! -d "./ts" ]; then
        mkdir "./ts"
    fi

    cd "./ts"

    if [ ! -e "./${project_name}.ts" ]; then
        > "./${project_name}.ts"
    fi

    cd "../"

}
