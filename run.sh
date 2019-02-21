#!/bin/bash


cd /home/container/windbot
git fetch origin master
git reset --hard FETCH_HEAD
xbuild /property:Configuration=Release /property:TargetFrameworkVersion=v4.5

cd /home/container/ygopro
git fetch origin server
git reset --hard FETCH_HEAD
git submodule foreach git fetch origin master
git submodule foreach git reset --hard FETCH_HEAD
premake4 gmake
cd build
make config=release
cd ..
strip ygopro

cd /home/container/ygopro-server
git fetch origin master
git reset --hard FETCH_HEAD
npm install --registry=https://registry.npm.taobao.org
node ygopro-server.js
