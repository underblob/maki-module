#!/bin/bash

source ./helpers/color.sh

color
color "${BLUE}Usage: npx maki-module <command> [options]"
color
color "${BLUE}Commands"
color
color "${BLUE}  install"
color "${BLUE}    Adds example templates and README at the current location."
color "${BLUE}    E.g.: npx maki-module install"
color
color "${BLUE}  make [--template=value] [--dest=path]"
color "${BLUE}    Create new from template at the destination path."
color "${BLUE}    E.g.: npx maki-module make --template=component --dest=./components/Button"
color "${BLUE}      --template  Corresponding template folder"
color "${BLUE}      --dest      Relative path to create from template"
color "${BLUE}      --children  Comma-delimited values to replace child tokens"
color "${BLUE}      --parents   Comma-delimited values to replace parent tokens"
color "${BLUE}      --self      Use this value instead of derived from --dest"
color
