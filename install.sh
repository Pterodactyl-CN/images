#!/bin/bash
cd /mnt/server
git clone https://code.pterodactyl.org.cn/moecube/ygopro.git --branch=server --recursive
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

git clone https://code.pterodactyl.org.cn/moecube/windbot.git
cd windbot
xbuild /property:Configuration=Release /property:TargetFrameworkVersion="v4.5"
ln -s bin/Release/WindBot.exe .
ln -s ../ygopro/cards.cdb .
cd ..

git clone https://code.pterodactyl.org.cn/moecube/srvpro.git ygopro-server
cd ygopro-server
npm install --registry=https://registry.npm.taobao.org
ln -s ../ygopro .
ln -s ../windbot .
mkdir config decks replays deck_log
cp data/default_config.json config/config.json
cd ..
