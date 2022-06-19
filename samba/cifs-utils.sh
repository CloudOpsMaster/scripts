#!/usr/bin/env bash

ip=$1

if [ -s ./settings.cfg ];
then 
    . ./settings.cfg
else 
    echo "There no setting.cfg file"
    exit 1
fi 

create_direcories(){
    mkdir -p $src/$shara 
    mkdir -p $src/$shara/$test_dir 

    if [ ! -d "$src/$shara" ];
    then 
        echo "There is no $src/$shara directory in tmp "
        exit 1
    fi    
}
create_direcories

install_cifs_utils(){
    apt install cifs-utils -y
}
install_cifs_utils

mount(){
    mount -t cifs //$ip$src/$shara $src/$shara
}
mount

