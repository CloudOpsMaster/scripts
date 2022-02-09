#!/usr/bin/env bash

. ./settings.cfg

if [ -s ./settings.cfg ]; then
   . ./settings.cfg
else
   echo There is not setting.cfg
fi
[ -z "$zabbix_server" ] && zabbix_server=10.142.0.2
[ -z "$listen_port" ] && listen_port=10050

mkdir -p /sybase/src
rm -rf /sybase/src/zabbix-$version

cd /sybase/src
if [ ! -s /sybase/src/zabbix-$version.tar.gz ]
then
    wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1EzjshcM0JwX14uRetpTb5JrkFT6k0l97' -O zabbix->
fi

tar -zxvf zabbix-$version.tar.gz 
cd /sybase/src/zabbix-$version
 ./configure --prefix=/sybase/zabbix --enable-agent --disable-dependency-tracking 
make install

/zabbix/etc/zabbix_agentd.conf

# This is a configuration file for Zabbix agent daemon (Unix)
# To get more information about Zabbix, visit http://www.zabbix.com

############ GENERAL PARAMETERS #################

### Option: PidFile

PidFile=/sybase/zabbix/zabbix_agentd.pid
LogFile=/sybase/zabbix/zabbix_agentd.log
Server=10.142.0.2
ServerActive=10.142.0.2

Hostname=mysql





# apt install libpcre3-dev -y 
# apt install gcc -y 
# apt install build-essential
