#!/bin/ash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"
echo "版权所有：MC部落 御坂云 TrollCraft SakuraMC 阿卡林云 零梦云 云上聊城，保留所有权利。"
echo "Powered By:MClans MisakaCloud TrollCraft SakuraMC AkkariinCloud ZeroDream CloudLiaocheng,All Rights Reserved."
# Run the Server
eval ${MODIFIED_STARTUP}