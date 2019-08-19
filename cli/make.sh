#!/bin/bash

source ./helpers/color.sh
source ./helpers/err.sh

color_init

CWD_DIR=$1
TEMPLATE=$2
PATH_ARG=$3

color "${BLUE}MAKE MODULE"
color

TPL_DIR="${CWD_DIR}/templates/${TEMPLATE}"
[  ! -d $TPL_DIR ] && color "${RED}Template does not exist: ${YELLOW}${TPL_DIR}" && err_abort 1
color "${BLUE}Absolute path to template: ${YELLOW}${TPL_DIR}"

MOD_DIR="${CWD_DIR}/${PATH_ARG}"
[ "${PATH_ARG:0:2}" == "./" ] && MOD_DIR="${CWD_DIR}/${PATH_ARG:2}"
[ "${PATH_ARG:0:1}" == "/" ] && MOD_DIR=$PATH_ARG
color "${BLUE}Absolute path to module: ${YELLOW}${MOD_DIR}"

color "${BLUE}Make folder ${YELLOW}${MOD_DIR}"
[ -d $MOD_DIR ] && color "${RED}Folder already exists." && err_abort 1
mkdir -p $MOD_DIR
err_abort $?

color
BASENAME=$(basename $MOD_DIR)
for TPL_FILE in $TPL_DIR/* ; do
  MOD_FILE=$(basename $TPL_FILE)
  MOD_FILE="${MOD_DIR}/${MOD_FILE//__BASENAME__/$BASENAME}"
  MOD_FILE="${MOD_FILE//.template/}"
  TPL_CONTENTS=$(<$TPL_FILE)
  color "${BLUE}Create file: ${YELLOW}${MOD_FILE}"
  echo "${TPL_CONTENTS//__BASENAME__/$BASENAME}" >> $MOD_FILE
done
color

color "${BLUE}Open folder"
open $MOD_DIR

color
color "${GREEN}Success!"
color
