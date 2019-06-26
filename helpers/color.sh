#!/bin/bash

# Usage for colored console output:
# ```
# source ./color.sh
# color "${BLUE} Script is processing."
# color "${YELLOW} Be careful of user input!"
# color "${GREEN} Script completed successfully."
# ```
#
# Outputs ORIGIN » MESSAGE
# Where ORIGIN is the relative script name. E.g.:
# ./install.sh » Script is processing

PRE='\033[0;240;2m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
END='\033[0m'

color_init() {
  clear
  echo -e "\n ${BLUE}PROCESS ${GREEN}SUCCESS ${YELLOW}WARN ${RED}FAIL ${END} \n"
}

color() {
  echo -e "${PRE}  ${END}$1${END}"
}
