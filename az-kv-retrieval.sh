#!/bin/bash

# Initialize variables for flags
client_id=false
secret=false
password=false

# Login to Azure using managed identity.
az login --identity

# Parse flags
while getopts ":csp" opt; do
  case $opt in
    c)
      client_id=true
      ;;
    s)
      secret=true
      ;;
    p)
      password=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Check if only one flag is set
if [[ $client_id == true && $secret == false && $password == false ]]; then
   CLIENTID=$(az keyvault secret show --vault-name bitwarden-creds-keyvault --name bw-alex-gonzalez-api-key-client-id --query value -o tsv)
   echo $CLIENTID

elif [[ $client_id == false && $secret == true && $password == false ]]; then
   SECRET=$(az keyvault secret show --vault-name bitwarden-creds-keyvault --name bw-alex-gonzalez-api-key-secret --query value -o tsv)
   echo $CLIENTSECRET

elif [[ $client_id == false && $secret == false && $password == true ]]; then
   PASSWORD=$(az keyvault secret show --vault-name bitwarden-creds-keyvault --name bw-alex-gonzalez-pw --query value -o tsv)
   echo $PASSWORD
else
  echo "Error: Please specify only one flag at a time (-c, -s, or -p)"
  exit 1
fi
