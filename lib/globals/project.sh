#!/bin/bash

project_name=""
project_shortName=""
project_locale=""
project_description=""
project_description_short=""
project_keywords=""
project_url=""
project_colour=""
project_license=""
project_version=""
project_language=""
project_type=""
project_scope=""
project_jsonld_price=""
project_jsonld_category=""
project_jsonld_compatibleSystems=""
project_typescript_target=""
project_requires_npm=""
project_requires_testingTools=""

# Defualt variable values.

project_default_name="set_it_up_project"
project_default_shortName="${this_program_name}Pro"
project_default_locale=$(echo $LANG | cut -d. -f1)
project_default_description="Project created by the '${this_program_name}' program!"
project_default_keywords="$this_program_name auto-generated project-starter"
project_default_colour="#551199"
project_default_version="1.0.0-development"
project_jsonld_default_price="FREE"
project_jsonld_default_category="BrowserApplication"
project_jsonld_default_compatibleSystems="$(uname)"
