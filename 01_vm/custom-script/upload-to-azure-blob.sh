#!/usr/bin/env bash

# Prerequisites:
# The following environment variable are set before running this script.
# - AZURE_STORAGE_ACCOUNT
# - AZURE_STORAGE_ACCESS_KEY

container_name=custom-script
file_name=update-install-yums.sh

az storage blob upload --container-name $container_name --file $file_name --name $file_name
