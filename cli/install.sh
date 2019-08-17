#!/bin/bash

source ./helpers/color.sh
source ./helpers/err.sh

color_init

PKG_DIR=$(pwd)
CWD_DIR=$1

color "${BLUE}INSTALL TEMPLATES"
color

color "${BLUE}Copy templates to ${YELLOW}${CWD_DIR}/templates"
[ -d "${CWD_DIR}/templates" ] && color "${RED}Folder already exists." && err_abort 1
cp -r "${PKG_DIR}/templates" "${CWD_DIR}/"
err_abort $?

color "${BLUE}Open folder"
open "${CWD_DIR}/templates"

color
color "${GREEN}Success!"
color
