#!/bin/bash

this_program_name="setItUp"
this_program_dirName="set_it_up"
this_program_version="0.1.11"

this_program_cache_dirName="cache"
this_program_cache_dirPath="$this_script_path/$this_program_cache_dirName"

this_option_external_files=true
this_option_package_files=true

this_project_customLicenseOption="CUSTOM-OR-NO-LICENSE"

this_project_licenses="AGPL-3.0-or-later AGPL-3.0-or-only GPL-3.0-only GPL-3.0-or-later LGPL-3.0-or-later LGPL-3.0-only MPL-2.0 Apache-2.0 MIT BSL-1.0 Unlicense $this_project_customLicenseOption"

declare -a this_project_languages
this_project_languages="JavaScript-TypeScript"
# this_project_languages="JavaScript-TypeScript PHP Python"

declare -A this_project_frameworks
this_project_frameworks["JavaScript-TypeScript"]="VanillaJS Webpack ViteJS"
# this_project_frameworks["PHP"]="VanillaPHP Laravel"
# this_project_frameworks["Python"]="VanillaPy Flask"
