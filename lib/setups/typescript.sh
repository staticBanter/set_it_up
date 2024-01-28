#!/bin/bash

function typescript_setTarget(){

    printf "Select your projects Typescript Environment Target:\n"

    allowedTypescriptTargets="es3 es5 es6/es2015 es2016 es2017 es2018 es2019 es2020 es2021 es2022 esnext"

    select typescriptTarget in $allowedTypescriptTargets
    do
        project_typescript_target=$typescriptTarget
        break;
    done

}

function setup_typescript()
{
    requires_typescript=""

    read -p "Will you be using TypeScript for this project? (Y/n)" requires_typescript

    if [[ "${requires_typescript}" == "n" || "${requires_typescript}" == "N" ]]; then
        return;
    fi

    typescript_setTarget

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
