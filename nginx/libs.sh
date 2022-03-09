#!/usr/bin/env bash

if [ -s ./settings.cfg ];
then 
    . ./settings.cfg 
else 
    echo "There no settings.cfg file"
    exit 1
fi 

create_directories(){
    mkdir -p $src
}

remove_old_libs(){
    for lib in $versions;
    do 
      rm $src/$lib.tar.gz 
      rm -rf $src/$lib
    done   
}

donload(){           
   for url in $array; 
   do
      echo $url
      cd $src && curl -O $url
   done
}

checks_libs(){
   for lib in $versions;
   do 
     if [ -f $src/$lib.tar.gz ];
     then 
         echo "$lib exist in $src "
     else 
         echo "$lib is not exist in $src "
     fi     
   done      
}

extract_libs(){
    for tar in $versions;
    do 
       cd $src && tar -zxf $tar.tar.gz
       if ! [ -d $src/$tar ];
       then 
          echo "$tar is not exist in $src "
       fi  
    done  
}

remove_old_libs
create_directories
donload
checks_libs
extract_libs

#- name:  rm tar nginx
#    shell: cd /sybase && rm nginx-{{version}}.tar.gz  
#  
#  - name: Download pcre-8.40
#    shell: cd /sybase && curl -O http://www.mirrorservice.org/sites/ftp.exim.org/pub/pcre/pcre-8.40.tar.gz
#
#  - name: tar pcre-8.40
#    shell: cd /sybase && tar -zxf pcre-8.40.tar.gz  
#
#  - name: rm tar pcre-8.40
#    shell: cd /sybase && rm pcre-8.40.tar.gz    
#
#  - name: Download zlib-1.2.11
#    shell: cd /sybase && curl -O https://fossies.org/linux/misc/zlib-1.2.11.tar.gz  
#
#  - name: tar zlib-1-2.11
#    shell: cd /sybase && tar -zxf zlib-1.2.11.tar.gz  
#  
#  - name: rm zlib-1-2.11
#    shell: cd /sybase && rm zlib-1.2.11.tar.gz  
#
#  - name: download openssl-1.0.2j
#    shell: cd /sybase && curl -O https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2j.tar.gz  
#
#  - name: tar openssl-1.0.2j
#    shell: cd /sybase && tar -zxf openssl-1.0.2j.tar.gz    
#
#  - name: rm openssl-1.0.2j.tar.gz
#    shell:  cd /sybase && rm openssl-1.0.2j.tar.gz 
