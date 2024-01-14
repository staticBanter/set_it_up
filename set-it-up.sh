#!/bin/bash

################################################################################
# setMeUp | Jordan Vezina(staticBanter) | December 18th 2023 - PRESENT
################################################################################

this_script_path=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
this_lib_path="$this_script_path/lib"

source $this_lib_path/globals/this.sh
source $this_lib_path/globals/client.sh
source $this_lib_path/globals/project.sh
source $this_lib_path/setups/client-information.sh
source $this_lib_path/setups/project-information.sh
source $this_lib_path/setups/projects.sh
source $this_lib_path/setups/readme.sh
source $this_lib_path/setups/git.sh
source $this_lib_path/setups/npm.sh
source $this_lib_path/setups/typescript.sh
source $this_lib_path/setups/javascript.sh
source $this_lib_path/setups/doc-tools.sh
source $this_lib_path/setups/test-tools.sh
source $this_lib_path/setups/css.sh
source $this_lib_path/setups/sass.sh
source $this_lib_path/setups/front-end.sh
source $this_lib_path/swap-template-file-variables.sh
source $this_lib_path/setups/projects/vanillajs.sh
source $this_lib_path/setups/projects/webpack.sh
source $this_lib_path/exit-phrase.sh

actuallyRunProgram=""

read -p "Whaooo are you actually trying to run the program? (y/N)" actuallyRunProgram

if [[ $actuallyRunProgram == "y" || $actuallyRunProgram == "Y" ]]; then
    setup_clientInformation
fi

exitPhrase

exit;
