#!/bin/bash

setup_project_webpack()
{

    setup_project_vanillajs

    if [ $this_option_package_files == true ]; then
        npm install --save-dev webpack webpack-cli webpack-dev-server copy-webpack-plugin terser-webpack-plugin
    else
        npm install --save-dev --package-lock-only --no-package-lock webpack webpack-cli webpack-dev-server copy-webpack-plugin terser-webpack-plugin
    fi

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"webpack-build\": \"webpack build \-\-profile \-\-json\=webpack.profile.json \-\-env production \-\-config webpack.config.js\","/ "./package.json"

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"webpack-dev-build\": \"webpack build \-\-env development \-\-config webpack.config.js\","/ "./package.json"

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"webpack-watch\": \"webpack build \-\-env development \-\-config webpack.config.js \-\-watch\","/ "./package.json"

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"start\": \"webpack serve\","/ "./package.json"

    sed -i s/"\"production\": \""/"\"production\": \"npm run webpack-build \&\& "/ "./package.json"

    if [ ! -e "./webpack.config.js" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/webpack.config.js" ]; then
            cp "$this_program_cache_dirPath/project_template_files/webpack.config.js" .
        fi
    fi

    webpack_devServer_domain=""
    webpack_default_devServer_domain="localhost"

    read -p "Enter a Localhost Domain Name for the Webpack Development Server (default: $webpack_default_devServer_domain)" webpack_devServer_domain

    if [ "${webpack_devServer_domain}"=="" ]; then

        webpack_devServer_domain=$webpack_default_devServer_domain

    fi

    sed -i s/"\[webpack_devServer_domain\]"/"$webpack_devServer_domain"/ "./webpack.config.js"

    webpack_devServer_port=""
    webpack_default_devServer_port="8080"

    read -p "Enter a Localhost Domain Name for the Webpack Development Server (default: $webpack_default_devServer_port)" webpack_devServer_domain

    if [ "${webpack_devServer_port}"=="" ]; then

        webpack_devServer_port=$webpack_default_devServer_port

    fi

    sed -i s/"\[webpack_devServer_port\]"/"$webpack_devServer_port"/ "./webpack.config.js"

    swapTemplateFileVariables "./webpack.config.js"

    mv "./web/" "./public/"

    mkdir "./web"

    mv "./public/" "./web/public/"

    if [ -e "./tsconfig.json" ]; then

        sed s/"\"outDir\": \"js\""/"\"outDir\": \"js\/module\""/ -i "./tsconfig.json"

    fi

    directories="js/bundle js/module web/src/js"

    for directory in $directories;
    do

        if [ ! -d "${directory}" ]; then

            mkdir -p $directory

        fi

    done;

    cd "./js/module"

    > "$project_name.js"

    cd "../../web/src/js"

    echo "'use strict';

import $project_name from \"../../../js/bundle/$project_name.bundle.js\";" > "main.js"

    cd "../"

    if [ ! -e "./manifest.json" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/manifest.json" ]; then
            cp "$this_program_cache_dirPath/project_template_files/manifest.json" .
        fi
    fi

    sed -i s/"\"start_url\": \"\[project_url\]\""/"\"start_url\": \"\(\[manifest_start_url\]\)\""/ "./manifest.json"

    swapTemplateFileVariables "manifest.json"

    cd "../public/js"

    if [ -e "./${project_name}.js" ]; then

        mv "./${project_name}.js" "./main.js"

        if [ -e "./index.html" ]; then

            sed -i s/"href=\".\/js\/$project_name.js\""/"href\=\".\/js\/main.js\""/ "./index.html"

        fi

    fi

    cd "../../../"

}
