#!/bin/bash

git clone https://github.com/moecube/ygopro --branch=server --recursive
cd ygopro/
git submodule foreach git checkout master
premake4 gmake
cd build/
make config=release
cd ..
ln -s bin/release/ygopro ./
strip ygopro
mkdir replay
cd ..

git clone https://github.com/moecube/windbot
cd windbot
xbuild /property:Configuration=Release /property:TargetFrameworkVersion="v4.5"
ln -s bin/Release/WindBot.exe .
ln -s ../ygopro/cards.cdb .
cd ..

git clone https://github.com/moecube/srvpro ygopro-server
cd ygopro-server
npm install --registry=https://registry.npm.taobao.org
ln -s ../ygopro .
ln -s ../windbot .
mkdir config decks replays deck_log
cp data/default_config.json config/config.json
cd ..
