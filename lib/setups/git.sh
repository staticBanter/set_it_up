#!/bin/bash

function create_githubDocs()
{

    declare -a documents

    documents="CODE-OF-CONDUCT.md CONTRIBUTING.md DEVELOPMENT.md SECURITY.md"

    for document in $documents; do

        if [ ! -a "./${document}" ]; then
            > "./${document}"
        fi

    done

}

function setup_git()
{
    requires_git=""

    read -p "Will you be using Git for version control? (Y/n)" requires_git

    if [[ "${requires_git}" == "n" || "${requires_git}" == "N" ]]; then
        return;
    fi

    git init

    switchToGitCredentials=""

    read -p "
        Would you like to change some of your configurations to your Git settings? (Y/n)
    " switchToGitCredentials

    if [ "${switchToGitCredentials}" != "n" ]; then

        client_name=$(git config --get user.name)
        client_email=$(git config --get user.email)

    fi

    if [ ! -e "./.gitignore" ]; then
        if [ -a "$this_program_cache_dirPath/project_template_files/.gitignore" ]; then
            cp "$this_program_cache_dirPath/project_template_files/.gitignore" .
        fi
    fi

    additionalDocumentation=""

    read -p "Would you like to Add Additional Documentation to your project? (Y/n)" additionalDocumentation

    if [[ "${additionalDocumentation}" != "n" && "${additionalDocumentation}" != "N" ]]; then

        if [ ! -d "./docs" ]; then

            mkdir "./docs"

            cd "./docs"

            create_githubDocs

            cd "../"

        fi

    fi

    githubProjectURL=""

    read -p "If your project has a Public Github URL enter it now: " githubProjectURL

    if [ "${githubProjectURL}" != "" ]; then
        project_url=$githubProjectURL
    fi

}
