#!/usr/bin/env bash
set -e

# HOST="http://git.dh.sogou-inc.com/api/v4/projects/";
# CI_PROJECT_ID="561";
# GITLAB_PRIVATE_TOKEN="Nxf8Ls8sXxk8UVqxjuFP";
# CI_COMMIT_REF_NAME="ci/cd";
# TARGET_BRANCH="master";
# CI_COMMIT_SHA="254b452d";


if [ -z "$GITLAB_PRIVATE_TOKEN" ]; then
  echo "GITLAB_PRIVATE_TOKEN not set"
  echo "Please set the GitLab Private Token as GITLAB_PRIVATE_TOKEN"
  exit 1
fi

# Extract the host where the server is running, and add the URL to the APIs
[[ $CI_PROJECT_URL =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

# Look which is the default branch
TARGET_BRANCH="master"

TAG="ci/cd";


TAGS=`curl --silent ${HOST}${CI_PROJECT_ID}/repository/tags --header \"PRIVATE-TOKEN:${GITLAB-PRIVATE-TOKEN}\"`;

COUNTTAGS=`echo $TAGS | grep -o "\"name\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;


if [ $COUNTTAGS -eq "0" ]; then
    
    echo "curl --request POST \"${HOST}${CI_PROJECT_ID}/${GITLAB_USER_ID}/repository/tags\" \
    --header \"PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}\" \
    --form "id=${GITLAB_USER_ID}" \
    --form \"tag_name=${CI_COMMIT_REF_NAME}\" \
    --form \"ref=${CI_COMMIT_SHA}\"";

    curl --request POST "${HOST}${CI_PROJECT_ID}/repository/tags" \
    --header "PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}" \
    --form "id=${GITLAB_USER_ID}" \
    --form "tag_name=${CI_COMMIT_REF_NAME}" \
    --form "ref=${CI_COMMIT_SHA}";
                
    exit;
fi

echo "no tag created";