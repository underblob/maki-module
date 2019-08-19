#!/bin/bash

err_message() {
  color "${RED}An operation failed with error code ${1}\n"
}

err_warn() {
  [ "${1}" -ne 0 ] && err_message "${1}"
}

err_abort() {
  [ "${1}" -ne 0 ] && err_message "${1}" && exit 0
}
