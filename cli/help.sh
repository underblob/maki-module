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
color "${BLUE}  make [template] [path]"
color "${BLUE}    Create a new template at path."
color "${BLUE}    E.g.: npx maki-module make component ./components/Button"
color
