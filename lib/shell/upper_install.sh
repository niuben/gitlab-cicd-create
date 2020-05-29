#!/usr/bin/env bash
set -e


. "$(dirname "$0")/config.sh"


echo $PROJECTPATH;

echo "判断是否存在项目文件夹";

# 创建项目文件夹
if [ ! -d $PROJECTPATH ]; then       

    mkdir $PROJECTPATH;

fi
echo  "已存在项目文件夹";

echo  "判断项目文件夹中是否存在node_modules";

# 每次都安装node_modules
# if [ ! -d "${PROJECTPATH}/node_modules" ]; then
    cp package.json $PROJECTPATH;
    
    cd $PROJECTPATH;

    npm config set registry https://registry.npm.taobao.org

    npm config set phantomjs_cdnurl https://npm.taobao.org/dist/phantomjs

    yarn install --ignore-engines;
# fi

echo  "项目文件夹已存在node_modules";

echo ${PROJECTPATH}/node_modules

# cd ${PROJECTPATH}/node_modules

# ls

cd ${PROJECTPATH}/node_modules/@babel

ls
# pwd;
# cd '../../../';
# pwd;