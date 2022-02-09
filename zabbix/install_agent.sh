#!/usr/bin/env bash

if [ -s ./setting.cfg ]; then
   . ./setting.cfg
else
   echo There is not setting.cfg
fi
[ -z "$zabbix_server" ] && zabbix_server= some server
[ -z "$listen_port" ] && listen_port=10050

mkdir -p /sybase/src
rm -rf /sybase/src/zabbix-$version

cd /sybase/src
if [ ! -s /sybase/src/zabbix-$version.tar.gz
then
    curl -O https://www.zabbix.com/documentation/$version/manual/concepts/agent
fi

tar -xzvf /sybase/src/zabbix-$version.tar.gz -C  /sybase/src
cd /sybase/src

