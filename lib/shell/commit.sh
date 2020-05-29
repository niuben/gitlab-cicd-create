#!/usr/bin/env bash
set -e

HOST="http://git.dh.sogou-inc.com/api/v4/projects/";
CI_PROJECT_ID="561";
GITLAB_PRIVATE_TOKEN="Nxf8Ls8sXxk8UVqxjuFP";
# CI_COMMIT_REF_NAME="ci/cd";
# TARGET_BRANCH="master";

if [ -z "$GITLAB_PRIVATE_TOKEN" ]; then
  echo "GITLAB_PRIVATE_TOKEN not set"
  echo "Please set the GitLab Private Token as GITLAB_PRIVATE_TOKEN"
  exit 1
fi

# Extract the host where the server is running, and add the URL to the APIs
[[ $CI_PROJECT_URL =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

curl --request POST \
--form "branch=abtest" \
--form "commit_message=create" \
--form "actions[][action]=create" \
--form "actions[][file_path]=/config/shell/commit.sh" \
--form "actions[][content]=<./config/shell/commit.sh" \
--header "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" \
"${HOST}${CI_PROJECT_ID}/repository/commits"

