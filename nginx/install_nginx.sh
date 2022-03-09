#!/usr/bin/env bash

if [ -s ./settings.cfg ]; 
then
    . ./settings.cfg
else
    echo "There no settings.cfg file"
    exit 1
fi 

create_direcories(){
    mkdir -p $src 
    mkdir -p $nginx_home 
}

remove_old_nginx(){
    if [ -f $src/$version.tar.gz ];
    then 
        rm $src/$version.tar.gz 
    fi     
}

download_nginx(){
    cd $src && curl -O $url
    if ! [ -f $src/$version.tar.gz ];
    then
        echo "nginx has no download sacced!"
        exit 1
    fi    
}

extract_nginx(){
    cd $src && tar -zxf $version.tar.gz
    if [ ! -d "$src/$version" ];
    then 
        echo "There is no nginx directory in src "
        exit 1
    fi     
}

configure(){
     cd $src/$version && ./configure  --prefix=/$nginx_home  --with-pcre=$src/pcre-8.40 --with-zlib=$src/zlib-1.2.11 --with-openssl=$src/openssl-1.0.2j --with-http_ssl_module --with-http_realip_module --with-http_stub_status_module --with-http_secure_link_module --with-http_v2_module --with-http_sub_module
}

make_install(){
    cd $src/$version make && make install
}


create_direcories
remove_old_nginx
download_nginx
extract_nginx
configure
make_install
