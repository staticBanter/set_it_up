#!/bin/bash

setup_clientInformation()
{

    read -p "Enter your Authoring Name for the project (default: $client_default_name): " client_name

    if [ "${client_name}" == "" ]; then
        client_name="$client_default_name"
    fi

    read -p "Enter an Email Address for the project. This will be used for people to contact you with inquiries about the project: " client_email

    read -p "Enter your Personal Websites URL: " client_url

    setup_projectInformation

}
