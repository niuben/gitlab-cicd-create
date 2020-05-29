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


TAGS=`curl --silent ${HOST}${CI_PROJECT_ID}/repository/tags --header \"PRIVATE-TOKEN:${GITLAB-PRIVATE-TOKEN}\"`;

#获取Tags list 如：v1.2 v1.3 v1.4
COUNTTAGS=`echo $TAGS | grep -Po "\"name\": *\"\K([^\"]*)" | tr ' ' ' '`;

#将字符串按照空格分隔成数组
COUNTTAGARRAY=(${COUNTTAGS// /});

{
    git checkout -b ${COUNTTAGARRAY[1]}
} || {
    yarn run build
    yarn run preview
    exit;     
}
yarn run build
yarn run preview 