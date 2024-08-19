#!/bin/bash


read -p "Input HostAddress: " REMOTE_ADDRESS

read -sp "Input Remote ssh  password: " PASSWD
export SSH_PASS=${PASSWD}
echo ""

read -sp "Input Host   sudo password: " PASSWD

export SSH_ASKPASS="./setPW.sh"
export DISPLAY="DUMMY"

function ErrorExit()
{
  if [ $1 -ne 0 ]; then
    echo "error ($1) $2"
    exit 1
  fi
}

function RemoteCommand()
{
  COMMAND="setsid ssh ${REMOTE_ADDRESS} \"$@\""
  echo "${COMMAND}"
  eval "${COMMAND}"
  ErrorExit $? "RemoteCommand"
}

function CopyToRemote()
{
  COMMAND="setsid scp $1 ${REMOTE_ADDRESS}:$2"
  echo "${COMMAND}"
  eval "${COMMAND}"
  ErrorExit $? "CopyToRemote"
}

REMOTE_CMD="ls -al"
RemoteCommand ${REMOTE_CMD}

REMOTE_CMD="\
  ~/work/aaa/test.sh abc;\
  pwd;\
  cd ~/work/aaa/;\
  pwd"
RemoteCommand ${REMOTE_CMD}

CopyToRemote "./setPW.sh" "~/work/aaa"

