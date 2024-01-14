#!/bin/bash

setup_sass()
{

    npm install --save-dev sass

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"sass-build\": \"sass site\/src\/main.scss:site\/prod\/main.css --style=compressed --no-source-map\",\n    \"sass-watch\": \"sass site\/src\/main.scss:site\/prod\/main.css --style=compressed --no-source-map --watch --update\","/ "./package.json"
    sed -i s/"\"production\": \""/"\"production\": \"npm run sass-build \&\& "/ "./package.json"

    if [ ! -d "./scss" ]; then

        mkdir "./scss"

        cd "./scss"

        > "./$project_name.scss"

        cd "../"

    fi

    setup_css

}
