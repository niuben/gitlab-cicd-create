#!/usr/bin/env bash
set -e

# HOST="http://git.dh.sogou-inc.com/api/v4/projects/";
# CI_PROJECT_ID="561";
# GITLAB_PRIVATE_TOKEN="Nxf8Ls8sXxk8UVqxjuFP";
# CI_COMMIT_REF_NAME="ci/cd";
# TARGET_BRANCH="master";

if [ -z "$GITLAB_PRIVATE_TOKEN" ]; then
  echo "GITLAB_PRIVATE_TOKEN not set"
  echo "Please set the GitLab Private Token as GITLAB_PRIVATE_TOKEN"
  exit 1
fi

# Extract the host where the server is running, and add the URL to the APIs
[[ $CI_PROJECT_URL =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

# Look which is the default branch
TARGET_BRANCH="master"

# The description of our new MR, we want to remove the branch after the MR has
# been closed
BODY="{
    \"id\": \"${CI_PROJECT_ID}\",
    \"source_branch\": \"${CI_COMMIT_REF_NAME}\",
    \"target_branch\": \"${TARGET_BRANCH}\",
    \"remove_source_branch\": false,
    \"title\": \"${CI_COMMIT_REF_NAME}\",
    \"WIP: \"${CI_COMMIT_REF_NAME}\",
    \"assignee_id\":\"${GITLAB_USER_ID}\"
}";

echo $BODY;

echo $GITLAB_PRIVATE_TOKEN;

# Require a list of all the merge request and take a look if there is already
# one with the same source branch
LISTMR=`curl --silent "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}"`;
COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;

# No MR found, let's create a new one
if [ ${COUNTBRANCHES} -eq "0" ]; then
    
    curl --request POST "${HOST}${CI_PROJECT_ID}/merge_requests" \
    --header PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN} \
    --form id=${CI_PROJECT_ID} \
    --form title=${CI_COMMIT_REF_NAME} \
    --form source_branch=${CI_COMMIT_REF_NAME} \
    --form target_branch=${TARGET_BRANCH};
    
    echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_NAME} and assigned to you";
    exit;
fi

echo "No new merge request opened";