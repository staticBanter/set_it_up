#!/bin/bash

################################################################################
# setMeUp | Jordan Vezina(staticBanter) | December 18th 2023 - PRESENT
################################################################################

if [ "$(id -u)" == "0" ]; then
	echo "ERROR: Cannot run as root user!"
	exit 1;
fi


this_script_path=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
this_lib_path="$this_script_path/lib"

if [ "${this_script_path}" == "" ]; then

    printf 'ERROR: Could not locate the path for this script... \n'
    exit 1;

elif [ "$this_script_path" == "/" ]; then

    continueWithRootDirectoryPath=""

    read -rp '
    WARNING: This scripts path is pointing to the ROOT (/) directory.
    This could be dangerous!
    Would you like to continue? (y/N)
    ' continueWithRootDirectoryPath

    if [[ "${continueWithRootDirectoryPath}" != "y" && "${continueWithRootDirectoryPath}" != "Y" ]]; then

        printf "Cancelling setup...\n"
        exit 1;

    fi

fi

source "$this_lib_path/globals/this.sh"
source "$this_lib_path/globals/client.sh"
source "$this_lib_path/globals/project.sh"
source "$this_lib_path/help.sh"
source "$this_lib_path/version.sh"
source "$this_lib_path/optExec.sh"
source "$this_lib_path/exit-phrase.sh"
source "$this_lib_path/setups/client-information.sh"
source "$this_lib_path/setups/project-information.sh"
source "$this_lib_path/setups/projects.sh"
source "$this_lib_path/setups/git.sh"
source "$this_lib_path/setups/licensing.sh"
source "$this_lib_path/setups/readme.sh"
source "$this_lib_path/setups/npm.sh"
source "$this_lib_path/setups/typescript.sh"
source "$this_lib_path/setups/javascript.sh"
source "$this_lib_path/setups/doc-tools.sh"
source "$this_lib_path/setups/test-tools.sh"
source "$this_lib_path/setups/css.sh"
source "$this_lib_path/setups/sass.sh"
source "$this_lib_path/setups/front-end.sh"
source "$this_lib_path/swap-template-file-variables.sh"
source "$this_lib_path/setups/projects/vanillajs.sh"
source "$this_lib_path/setups/projects/webpack.sh"
source "$this_lib_path/setups/projects/vitejs.sh"

optExec "$@"

setup_clientInformation

exitPhrase

exit 0;
