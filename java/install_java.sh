#!/usr/bin/env bash

if [ -s ./settings.cfg ];
then  
    . ./settings.cfg 
fi 

crearte_directories(){
   mkdir -p "$java_home"
   mkdir -p "$src"
}

remove_old_java(){
    if [ -d "$java_home/$version" || -d "$src/$version.tar.gz"]; 
    then 
        rm $src/$version.tar.gz
        rm -rf $java_home/$version
    fi    
}

download_java(){
     cd $src && wget $url
     if ! [ -f "$src/$version.tar.gz" ];
     then
         cd $src && ls -la
         echo "There is now $version archive"
     fi 
}

extract_java(){
   cd $src && tar -zxvf $version.tar.gz -C $java_home --strip-components=1
   cd $java_home && echo "$(grep -e "JAVA_VERSION" release )"
}

crearte_directories
remove_old_java
download_java
extract_java
