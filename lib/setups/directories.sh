#!/bin/bash

function setup_directories()
{
    case $projectType in

        "VanillaJS") setup_directories_vanillajs;;

    esac
}
