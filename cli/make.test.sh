#!/bin/bash

source ./helpers/color.sh
source ./helpers/err.sh
source ./cli/make.mock.sh

color_init

CWD_DIR="$(pwd)"

color "${BLUE}MAKE.TEST"

FAIL_COUNT=0
PASS_COUNT=0
expect_count() {
  if [[ "$1" == *"FAIL"* ]] ; then
    FAIL_COUNT=$(($FAIL_COUNT + 1))
  else
    PASS_COUNT=$(($PASS_COUNT + 1))
  fi
}

FAIL=$(color "${YELLOW}FAIL")
PASS=$(color "${GREEN}PASS")

color
color "${BLUE}Argument validation: Missing template"
RES=$(node ./cli.js make --template=missing-foo-bar --dest=.test/folder-mc-fern)

EXPECT=$([[ "${RES}" == *"Template does not exist"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Error message ${EXPECT}"
expect_count "${EXPECT}"

EXPECT=$([[ "${RES}" == *"failed with error code 1"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Error code: ${EXPECT}"
expect_count "${EXPECT}"

color
color "${BLUE}Argument validation: Folder already exists"
SETUP=$(node ./cli.js make --template=example-react --dest=.test/folder-mc-fern)
RES=$(node ./cli.js make --template=example-react --dest=.test/folder-mc-fern)

EXPECT=$([[ "${RES}" == *"Folder already exists"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Error message: ${EXPECT}"
expect_count "${EXPECT}"

EXPECT=$([[ "${RES}" == *"failed with error code 1"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Error code: ${EXPECT}"
expect_count "${EXPECT}"

color
color "${BLUE}Filesystem validation: Folder and files are created"

RES="${CWD_DIR}/.test/folder-mc-fern"
EXPECT=$([ -d $RES ] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Folder exists: ${EXPECT}"
expect_count "${EXPECT}"

RES=$(ls "${CWD_DIR}/.test/folder-mc-fern")
EXPECT=$([[ "${RES}" == *"folder-mc-fern.scss"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT SASS file exists: ${EXPECT}"
expect_count "${EXPECT}"

EXPECT=$([[ "${RES}" == *"FolderMcFern.js"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT JS file exists: ${EXPECT}"
expect_count "${EXPECT}"

EXPECT=$([[ "${RES}" == *"FolderMcFern.test.js"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT JS test file exists: ${EXPECT}"
expect_count "${EXPECT}"

EXPECT=$([[ "${RES}" == *"index.js"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT index file exists: ${EXPECT}"
expect_count "${EXPECT}"

color
color "${BLUE}File contents validation: check token replacement"

RES=$(cat "${CWD_DIR}/.test/folder-mc-fern/folder-mc-fern.scss")
EXPECT=$([[ "${RES}" == *"${MOCK_EXAMPLE_REACT_SCSS}"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT SASS file validation: ${EXPECT}"
expect_count "${EXPECT}"

RES=$(cat "${CWD_DIR}/.test/folder-mc-fern/FolderMcFern.js")
EXPECT=$([[ "${RES}" == *"${MOCK_EXAMPLE_REACT_JS}"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT JS file validation: ${EXPECT}"
expect_count "${EXPECT}"

RES=$(cat "${CWD_DIR}/.test/folder-mc-fern/FolderMcFern.test.js")
EXPECT=$([[ "${RES}" == *"${MOCK_EXAMPLE_REACT_TEST}"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT JS test file validation: ${EXPECT}"
expect_count "${EXPECT}"

RES=$(cat "${CWD_DIR}/.test/folder-mc-fern/index.js")
EXPECT=$([[ "${RES}" == *"${MOCK_EXAMPLE_REACT_INDEX}"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT index file validation: ${EXPECT}"
expect_count "${EXPECT}"

color
color "${BLUE}Lineage template validation: folder and files are created"
SETUP=$(node ./cli.js make --template=lineage --dest=.test/family-tree --self=oneMe --parents=grand,greatGrand,gggGranny --children=child,grandChild,greatChild)

RES="${CWD_DIR}/.test/family-tree"
EXPECT=$([ -d $RES ] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Folder exists: ${EXPECT}"
expect_count "${EXPECT}"

RES=$(ls "${CWD_DIR}/.test/family-tree")
EXPECT=$([[ "${RES}" == *"one-me.md"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT MD file exists: ${EXPECT}"
expect_count "${EXPECT}"

color
color "${BLUE}Lineage template validation: check token replacement"

RES=$(cat "${CWD_DIR}/.test/family-tree/one-me.md")
EXPECT=$([[ "${RES}" == *"${MOCK_LINEAGE_MD}"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT MD file validation: ${EXPECT}"
expect_count "${EXPECT}"

color
color "${BLUE}Flatten directory argument"
SETUP=$(node ./cli.js make --template=lineage --dest=.test/FLAT_BILL --flatten=true)

EXPECT=$([[ "${SETUP}" == *"Flattening the module folder"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Message for module folder: ${EXPECT}"
expect_count "${EXPECT}"

EXPECT=$([[ "${SETUP}" == *"Moved files to the parent folder"* ]] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Message for parent folder: ${EXPECT}"
expect_count "${EXPECT}"

RES="${CWD_DIR}/.test/flat-bill.md"
EXPECT=$([ -f $RES ] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT File moved to parent: ${EXPECT}"
expect_count "${EXPECT}"

RES="${CWD_DIR}/.test/FLAT_BILL"
EXPECT=$([ ! -d $RES ] && echo $PASS || echo $FAIL)
color "${BLUE}EXPECT Folder deleted: ${EXPECT}"
expect_count "${EXPECT}"

if [ "${FAIL_COUNT}" -ne 0 ] ; then
  color
  color "${RED}There are ${FAIL_COUNT} failing tests" && err_abort 1
  color
fi

color
color "${GREEN}${PASS_COUNT} tests passed successfully"
color "${GREEN}Done"
color
