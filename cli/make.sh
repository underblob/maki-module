#!/bin/bash

source ./helpers/color.sh
source ./helpers/err.sh

color_init

CWD_DIR=$1

color "${BLUE}MAKE MODULE"
color

for ARG in "$@" ; do
  [[ "$ARG" == "--children="* ]] && export CHILDREN="${ARG:11}"
  [[ "$ARG" == "--dest="* ]] && export DEST="${ARG:7}"
  [[ "$ARG" == "--flatten="* ]] && export FLATTEN="${ARG:10}"
  [[ "$ARG" == "--parents="* ]] && export PARENTS="${ARG:10}"
  [[ "$ARG" == "--self="* ]] && export SELF="${ARG:7}"
  [[ "$ARG" == "--template="* ]] && export TEMPLATE="${ARG:11}"
done

# Template validation
TPL_DIR="${CWD_DIR}/templates/${TEMPLATE}"
[  ! -d $TPL_DIR ] && color "${RED}Template does not exist: ${YELLOW}${TPL_DIR}" && err_abort 1
color "${BLUE}Absolute path to template: ${YELLOW}${TPL_DIR}"

# Module directory normalization
MOD_DIR="${CWD_DIR}/${DEST}"
[ "${DEST:0:2}" == "./" ] && MOD_DIR="${CWD_DIR}/${DEST:2}"
[ "${DEST:0:1}" == "/" ] && MOD_DIR=$DEST
color "${BLUE}Absolute path to module: ${YELLOW}${MOD_DIR}"

color "${BLUE}Make folder ${YELLOW}${MOD_DIR}"
# Module directory validation
[ -d $MOD_DIR ] && color "${RED}Folder already exists." && err_abort 1
mkdir -p $MOD_DIR
err_abort $?

color

BASENAME=$(basename $MOD_DIR)
SELF=$([ "${SELF}" != "" ] && echo "${SELF}" || echo $BASENAME)

function convert {
  echo $(node ./cli/make/convert_case.js $1 $2)
}

function convert_contents {
  CONTENTS=$1
  CASE=$2

  # Support the __base-name__ token for backwards-compatibility
  TOKEN="__$(convert $CASE base-name)__"
  REPLACEMENT="$(convert $CASE $SELF)"
  CONTENTS="${CONTENTS//$TOKEN/$REPLACEMENT}"

  # Replace the --self argument with __self-name__ tokens
  TOKEN="__$(convert $CASE self-name)__"
  REPLACEMENT=$(convert $CASE $SELF)
  CONTENTS="${CONTENTS//$TOKEN/$REPLACEMENT}"

  # Loop through --children for replacement with __child-name-1__ tokens
  if [ "${CHILDREN}" != "" ] ; then
    IFS=',' ; ARR_CHILDREN=($CHILDREN)
    for i in "${!ARR_CHILDREN[@]}" ; do
      TOKEN="__$(convert $CASE "child-name-$((i + 1))")__"
      REPLACEMENT=$(convert $CASE "${ARR_CHILDREN[i]}")
      CONTENTS="${CONTENTS//$TOKEN/$REPLACEMENT}"
    done
    # Replace singular token __child-name__
    TOKEN="__$(convert $CASE child-name)__"
    REPLACEMENT=$(convert $CASE "${ARR_CHILDREN[0]}")
    CONTENTS="${CONTENTS//$TOKEN/$REPLACEMENT}"
  fi

  # Loop through --parents for replacement with __parent-name-1__ tokens
  if [ "${PARENTS}" != "" ] ; then
    IFS=',' ; ARR_PARENTS=($PARENTS)
    for i in "${!ARR_PARENTS[@]}" ; do
      TOKEN="__$(convert $CASE "parent-name-$((i + 1))")__"
      REPLACEMENT=$(convert $CASE "${ARR_PARENTS[i]}")
      CONTENTS="${CONTENTS//$TOKEN/$REPLACEMENT}"
    done
    # Replace singular token __parent-name__
    TOKEN="__$(convert $CASE parent-name)__"
    REPLACEMENT=$(convert $CASE "${ARR_PARENTS[0]}")
    CONTENTS="${CONTENTS//$TOKEN/$REPLACEMENT}"
  fi

  echo "${CONTENTS}"
}

for TPL_FILE in $TPL_DIR/* ; do
  MOD_FILE=$(basename $TPL_FILE)

  MOD_FILE=$(convert_contents "${MOD_FILE}" camel)
  MOD_FILE=$(convert_contents "${MOD_FILE}" constant)
  MOD_FILE=$(convert_contents "${MOD_FILE}" kebab)
  MOD_FILE=$(convert_contents "${MOD_FILE}" pascal)
  MOD_FILE=$(convert_contents "${MOD_FILE}" snake)

  MOD_FILE="${MOD_FILE//.template/}"
  color "${BLUE}Make file ${YELLOW}${MOD_FILE}"

  MOD_CONTENTS=$(<$TPL_FILE)

  MOD_CONTENTS=$(convert_contents "${MOD_CONTENTS}" camel)
  MOD_CONTENTS=$(convert_contents "${MOD_CONTENTS}" constant)
  MOD_CONTENTS=$(convert_contents "${MOD_CONTENTS}" kebab)
  MOD_CONTENTS=$(convert_contents "${MOD_CONTENTS}" pascal)
  MOD_CONTENTS=$(convert_contents "${MOD_CONTENTS}" snake)

  echo "${MOD_CONTENTS}" >> "${MOD_DIR}/${MOD_FILE}"
done

if [ "${FLATTEN}" == "true" ] ; then
  color
  color "${BLUE}Flattening the module folder at ${YELLOW}${MOD_DIR}"
  FLATTEN_DIR=$(dirname "${MOD_DIR}")
  cp -r "${MOD_DIR}/"* "${FLATTEN_DIR}"
  rm -rf "${MOD_DIR}"
  color "${BLUE}Moved files to the parent folder ${YELLOW}${FLATTEN_DIR}"
fi

color
color "${GREEN}Success!"
color
