#!/bin/bash
#
#############
#Owner:Palash Lochan Mahapatra
#About:to list read accessed users in a repo of a orgainsation using shell scripting and github api 
#Input:Username,Access token
#Date:9th July 2024
#############
#
#
helper()
# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

#Adding helper command to display error 
function helper{
	expected_cmd_args=2
	if[ $# -ne expected_cmd_args]; then
		echo"Please execute the script with required cmd args"
		echo"asd"
	}		

# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access


#To connect and run on a vm
#Create an EC2 instance logging into ur AWS Account
#Coonect with the VM created using termninal
ssh ubuntu@52.66.184.149
#change the permission of the key pair
chmod 600 /Users/Downloads/test76.pem
#Now establish with the VM
ssh -i /Users/Downloads/test76.pem ubuntu@52.66.184.149
#Now the coonection is setup with the AWS EC2 instance(VM)
#Now the clone with the github repo 
git clone https://github.com/Palash-7719/Shell_Scripting_Project
ls
#Shell_Scripting_Project
cd Shell_Scripting_Project
#README.md #github-api
cd github-api
ls
#list_read_users.sh
#Now export username & token access
export username="Palash-7719"
export token="Token"
./list_read_users.sh
#opened the file and provide the command line arguments
#Create a repo with ur organisation
./list_read_users.sh Devops-example-77 demo-1
#if permission denied
chmod 777 list_read_users.sh
./list_read_users.sh Devops-example-77 demo-1
#It now list the users having read access within the organisation 
#We can also change the permission for the other aspects such as admin,write etc using jq command as for a Json format file




