#!/usr/bim/env bash

phpVersion=$(php --version | head -n 1 | cut -d " " -f 2 | cut -c  1-3 )

check_setting(){
    if [ -s ./settings.cfg ];
    then
        . ./settings.cfg
    else
        echo "There is no setting.cfg"
        exit 1
    fi     
}

create_directories(){
    mkdir -p /sybase/zabbix
    mkdir -p /sybase/zabbix/logs
    mkdir -p /sybase/zabbix/pid 
    mkdir -p /var/www/html/zabbix/conf
    mkdir -p /sybase/src
}

stop_zabbix_server(){
    if [ -f /sybase/zabbix/pid/zabbix_server.pid ]; 
    then
        kill $(cat /sybase/zabbix/pid/zabbix_server.pid)
    fi
}

remove_old_zabbix(){
    rm -rf $zabbix_home/zabbix*.tar.gz
    rm -rf $zabbix_home/zabbix*
}

download_zabbix(){
   cd $zabbix_home
   if [ ! -s $zabbix_home/$version.tar.gz ]; 
   then 
      cd $zabbix_home &&  curl -O $url
   fi    
}

extract_tar(){
   cd $zabbix_home
   if [ -f $zabbix_home/$version.tar.gz ];
   then
       cd $zabbix_home && tar -zxvf $version.tar.gz
   else
       echo "Can't find $version.tar.gz in $zabbix_home" 
       exit 1
   fi       
}

configure_server(){
   if [ -d $zabbix_home/$version ]; 
   then 
       cd $zabbix_home/$version
       ./configure --prefix=$zabbix --enable-server --enable-agent --with-mysql
    else
        echo "Can't find $zabbix, creating $zabbix...."
        mkdir -p $zabbix
    fi       
}

make_install(){
    if [ -d $zabbix_home/$version ];
    then 
        cd $zabbix_home/$version 
        make install
    else 
        echo "Cen't find $zabbix_home/$version"
        exit 1
    fi        
}

copy_ui(){
    if [ -d $zabbix_home/$version ];
    then
        cp -r $zabbix_home/$version/ui/* /var/www/html/zabbix
    else 
        echo "Can't find $zabbix_home/$version "
    fi        
}

coppy_server_conf(){
   if [ -f $zabbix/etc/zabbix_server.conf ];
   then
       rm $zabbix/etc/zabbix_server.conf
       cp $copy_from/zabbix_server.conf $zabbix/etc
   else
       cp $copy_from/zabbix_server.conf $zabbix/etc
   fi
}

coppy_php_conf(){
   if [ -f /var/www/html/zabbix/conf/zabbix.conf.php ];
   then 
       rm /var/www/html/zabbix/conf/zabbix.conf.php
       cp $copy_from/zabbix.conf.php /var/www/html/zabbix/conf
   else
       cp $copy_from/zabbix.conf.php /var/www/html/zabbix/conf
   fi

}

copy_php_ini(){
  if [ -f /etc/php/$phpVersion/apache2/php.ini ];
  then
      rm /etc/php/$phpVersion/apache2/php.ini
      cp /sybase/scripts/zabbix/php.ini /etc/php/$phpVersion/apache2
  else
      mkdir -p /etc/php/$phpVersion/apache2
      cp $copy_from/zabbix/php.ini /etc/php/$phpVersion/apache2
  fi
}


check_setting
create_directories
stop_zabbix_server
remove_old_zabbix
download_zabbix
extract_tar
configure_server
make_install
copy_ui
coppy_server_conf
coppy_php_conf
copy_php_ini


























download_zabbix(){
   cd $zabbix_home
   if [ ! -s $zabbix_home/$version.tar.gz ]; 
   then 
       curl -O $url
   fi    
}

extract_tar(){
   cd $zabbix_home
   if [ -f $zabbix_home/$version.tar.gz ];
   then
       cd $zabbix_home && tar -zxvf $version.tar.gz
   else
       echo "Can't find $version.tar.gz in $zabbix_home" 
       exit 1
   fi       
}

configure_server(){
   if [ -d $zabbix_home/$version ]; 
   then 
       cd $zabbix_home/$version
       ./configure --prefix=$zabbix --enable-server --enable-agent --with-mysql
    else
        echo "Can't find $zabbix, creating $zabbix...."
        mkdir -p $zabbix
    fi       
}

make_install(){
    if [ -d $zabbix_home/$version ];
    then 
        cd $zabbix_home/$version 
        make install
    else 
        echo "Cen't find $zabbix_home/$version"
        exit 1
    fi        
}

copy_ui(){
    if [ -d $zabbix_home/$version ];
    then
        cp -r $zabbix_home/$version/ui/* /var/www/html/zabbix
    else 
        echo "Can't find $zabbix_home/$version "
    fi        
}

coppy_server_conf(){
   if [ -f $zabbix/etc/zabbix_server.conf ];
   then
       rm $zabbix/etc/zabbix_server.conf
   fi
    
    if [ -f ./zabbix_server.conf ]; 
    then 
        cp /sybase/scripts/zabbix/zabbix_server.conf $zabbix/etc
    fi
}

coppy_php_conf(){
   if [ -f /var/www/html/zabbix/conf/zabbix.conf.php ];
   then 
       rm /var/www/html/zabbix/conf/zabbix.conf.php
       cp /sybase/scripts/zabbix/zabbix.conf.php /var/www/html/zabbix/conf
   fi

}









check_setting
create_directories
stop_zabbix_server
remove_old_zabbix
download_zabbix
extract_tar
configure_server
make_install
copy_ui
coppy_server_conf
coppy_php_conf