#!/bin/bash

function swapTemplateFileVariables()
{

    declare -A file_variable_replacements

    file_variable_replacements["\[project_name\]"]="$project_name"
    file_variable_replacements["\[project_name_short\]"]="$project_name_short"
    file_variable_replacements["\[project_locale\]"]="$project_locale"
    file_variable_replacements["\[project_url\]"]="$project_url"
    file_variable_replacements["\[project_colour\]"]="$project_colour"
    file_variable_replacements["\[project_keywords\]"]="$project_keywords"
    file_variable_replacements["\[project_description\]"]="$project_description"
    file_variable_replacements["\project_description_short\]"]="$project_description_short"
    file_variable_replacements["\[client_name\]"]="$client_name"
    file_variable_replacements["\[project_jsonld_price\]"]="$project_jsonld_price"
    file_variable_replacements["\[project_jsonld_category\]"]="$project_jsonld_category"
    file_variable_replacements["\[project_jsonld_compatibleSystems\]"]="$project_jsonld_compatibleSystems"

    for file_variable in "${!file_variable_replacements[@]}"
    do

        if [[ "${file_variable}" && "${file_variable_replacements[$file_variable]}" ]]; then

            if [[ $1 == "manifest.json" && $file_variable == "\[project_keywords\]" ]]; then

                sed -i s/"\"\[project_keywords\]"\"/""/ "./$1"

                projectKeywordsIndex=0

                for keyword in $project_keywords; do

                    if [ $projectKeywordsIndex == 0 ]; then
                        sed -i s/"\"categories\": \["/"\"categories\": \[\"$keyword\" "/ "./$1"
                    else
                        sed -i s/"\"categories\": \["/"\"categories\": \[\"$keyword\", "/ "./$1"
                    fi

                    ((projectKeywordsIndex++))

                done

            else

                sed -i s/"$file_variable"/"${file_variable_replacements[$file_variable]}"/ "./$1"

            fi

        fi

    done

}
