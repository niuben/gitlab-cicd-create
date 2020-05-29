#!/usr/bin/env bash
set -e

npm config set registry https://registry.npm.taobao.org

npm config set phantomjs_cdnurl https://npm.taobao.org/dist/phantomjs

# yarn install --ignore-engines --frozen-lockfile

npm ci

# pwd;
# cd '../../../';
# pwd;