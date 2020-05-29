#!/usr/bin/env bash
export NODE_PATH="/d/www/_/node_modules";

set -e

CI_PROJECT_NAME="123";

pwd

# if [ -d ../_zhushou-redpackage/node_modules ]; then
#     ../_zhushou-redpackage/node_modules/.bin/jest
# else 
#     yarn install --ignore-engines
#     jest
# fi

# ../_${CI_PROJECT_NAME}/node_modules/.bin/jest




NODE_PATH=/d/www/_/node_modules yarn run test