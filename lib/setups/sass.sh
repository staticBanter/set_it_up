#!/bin/bash

setup_sass()
{

    requires_sass=""

    read -p "Would you like to use SASS/SCSS? (Y/n)" requires_sass

    if [[ "${requires_sass}" == "n" ||  "${requires_sass}" == "N" ]]; then
        return;
    fi

    npm install --save-dev sass

    sed -i s/"\"scripts\": {"/"\"scripts\": {\n    \"sass-build\": \"sass .\/scss\/$project_name.scss:.\/css\/$project_name.css --style=compressed --no-source-map\",\n    \"sass-watch\": \"sass .\/scss\/$project_name.scss:.\/css\/$project_name.css --style=compressed --no-source-map --watch --update\","/ "./package.json"

    sed -i s/"\"production\": \""/"\"production\": \"npm run sass-build \&\& "/ "./package.json"

    if [ ! -d "./scss" ]; then

        mkdir "./scss"

        cd "./scss"

        > "./$project_name.scss"

        cd "../"

    fi

    setup_css

}
