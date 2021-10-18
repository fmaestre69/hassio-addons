#!/bin/bash
set -e

CONFIG_PATH=/data/options.json
HOSTNAME=$(jq --raw-output ".hostname" $CONFIG_PATH)
SSH_PORT=$(jq --raw-output ".ssh_port" $CONFIG_PATH)
USERNAME=$(jq --raw-output ".username" $CONFIG_PATH)
PASSWORD=$(jq --raw-output ".password" $CONFIG_PATH)
REMOTE_FORWARDING=$(jq --raw-output ".remote_forwarding[]" $CONFIG_PATH)

command_args="ssh -N -R $REMOTE_FORWARDING $USERNAME@$HOSTNAME"

if [ ! -z "$REMOTE_FORWARDING" ]; then
  while read -r line; do
    command_args="${command_args} -R $line"
  done <<< "$REMOTE_FORWARDING"
fi

echo "[INFO] Launching sshpass with command args: ${command_args}"

# Start autossh
/usr/bin/sshpass -p $(PASSWORD) ${command_args}
