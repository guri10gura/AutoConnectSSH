#!/bin/bash

if [ -n "${SSH_PASS}" ]; then
  echo "${SSH_PASS}"
  exit 0
fi
exit 1
