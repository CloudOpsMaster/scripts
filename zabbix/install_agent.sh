#!/usr/bin/env bash

confFile=./zabbix_agentd.conf

create_directories(){
   mkdir -p /sybase/src
   mkdir -p /sybase/zabbix/logs
   mkdir -p /sybase/zabbix/pid
}

check_settings(){
  if [ -s ./settings.cfg ]; then
     . ./settings.cfg
  else
   echo "There is not setting.cfg"
   exit 1
  fi
}

remove_old_zabbix(){
   rm -rf $zabbix_home/$version
   rm $zabbix_home/$version.tar.gz
}

download_zabbix(){
    cd $zabbix_home
    if [ ! -s $zabbix_home/$version.tar.gz ];
    then
        curl -O $url
    fi
}

extract_zabbix(){
   if [ -f $zabbix_home/$version.tar.gz ]; 
   then
       cd $zabbix_home &&  tar -zxvf $version.tar.gz  -C $zabbix
   else
       echo "There have no $version.tar.gz in $zabbix_home"
       exit 1
   fi
         
}

configure_host_name(){
     [ -z "$zabbix_server" ] && zabbix_server=10.142.0.0
     [ -z "$listen_port" ] && listen_port=10050
     [ -z "$hostname" ] && hostname=`cat /proc/sys/kernel/hostname` 
      # echo "$hostname"
      sed -ie '/Hostname *=/ s|=.*$|='$(echo "$hostname")'|' confFile
      sed -ie '/PidFile *=/ s|=.*$|='$(echo "$PidFile")'|' confFile
      sed -ie '/LogFile *=/ s|=.*$|='$(echo "$LogFile")'|' confFile
      sed -ie '/ServerActive *=/ s|=.*$|='$(echo "$zabbix_server")'|' confFile
      sed -ie '/Server *=/ s|=.*$|='$(echo "$zabbix_server")'|' confFile
}


copy_zabbix_conf(){
   if [ -f "$zabbixConfigRemove" ];
   then
        echo "File $zabbixConfigRemove exist and then remove"
        rm $zabbixConfigRemove/zabbix_agentd.conf
   else 
        echo "copy zabbix_agentd.conf to zabiix/conf"
        cp $copy_from/zabbix_agentd.conf $copy_to
   fi
}


 create_directories
 check_settings
 remove_old_zabbix
 download_zabbix
 extract_zabbix
 configure_host_name
 copy_zabbix_conf



echo "Success!"

# apt install libpcre3-dev -y 
# apt install gcc -y 
# apt install build-essential

