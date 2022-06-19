#!/usr/bin/env bash

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

install_samba(){
    apt install samba -y 
    samba_ver="$(samba --version | cut -d ' ' -f2 | cut -d '-' -f1)"
    echo $samba
}
install_samba

remove_old_smb_conf(){
    if [ -f /etc/samba/smb.conf ];
    then 
        rm /etc/samba/smb.conf
    fi     
}
remove_old_smb_conf

copy_smb_conf(){
    cp $src/$samba_conf /etc/samba/smb.conf
    if [ ! -f /etc/samba/smb.conf ];
    then 
        echo "File smb.conf not exist in /etc/samba/"
        exit 1
    fi     
}
copy_smb_conf

permision(){
    chmod -R 0755 $src/$shara 
}
permision

owner(){
    # chown -R nobody:nogroup $src/$shara
    echo "root owner"
}
owner