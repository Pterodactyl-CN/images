#!/bin/ash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"
echo "版权所有:MClans MisakaCloud TrollCraft SakuraMC AkkariinCloud"
echo "Powered By:MClans MisakaCloud TrollCraft SakuraMC AkkariinCloud"
# Run the Server
eval ${MODIFIED_STARTUP}