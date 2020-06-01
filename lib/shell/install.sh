#!/usr/bin/env bash
set -e

npm config set registry https://registry.npm.taobao.org

npm config set phantomjs_cdnurl https://npm.taobao.org/dist/phantomjs

npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/

npm config set electron_mirror https://npm.taobao.org/mirrors/electron/

# yarn install --ignore-engines --frozen-lockfile

npm ci

# pwd;
# cd '../../../';
# pwd;