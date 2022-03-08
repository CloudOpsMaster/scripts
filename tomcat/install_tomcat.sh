#!/usr/bin/env bash

check_setings(){
   if [ -s ./settings.cfg ];
   then
       . ./settings.cfg
   else
       echo "There is no settings file"
       exit 1
   fi       
}

create_directories(){
    mkdir -p $tomcatDir
    mkdir -p $tomcat_home
}

remove_tomcat(){
   if [ -f "$tomcat_home/$version.tar.gz" || -d "$tomcat_home/$version" ];
   then
       rm -rf $tomcat_home/$versio*
   fi
}

download_tomcat(){
    cd $tomcat_home && curl -O $url
    if ! [ -f $tomcat_home/$version.tar.gz ]; 
    then
        echo "Can't find tomcat.tar.gz in $tomcat_home !"
        exit 1
    fi     
}

extract_tar_gz(){
   # cd $tomcat_home  && tar xzvf $version.tar.gz -C /sybase/tomcat --strip-components=1
   ls | grep "$version.tar.gz" | while read i; do tar xzvf $i -C $tomcatDir; mv $tomcatDir/$version $tomcatDir/$appName; done
   if ! [ -d "$tomcatDir/$appName" ]; 
   then
       echo "Directory $appName not exist"
       exit 1
   fi    

}

copy_setenv(){
    cp $scriptsUrl/tomcat/setenv.sh $tomcatDir/$appName/bin
    if ! [ "$tomcatDir/$appName/bin/setenv.sh" ]; 
    then
        echo "setenv not exist in $tomcatDir/$appName/bin" 
        exit 1
    fi    
}

catalina_out(){
    cd $tomcatDir/$appName/logs && touch catalina.out
    if ! [ -f "$tomcatDir/$appName/logs/catalina.out" ]; 
    then
        echo "Catalina out not exist in $tomcatDir/$appName/logs/"
        exit 1
    fi    
}

check_setings
create_directories
remove_tomcat
download_tomcat
extract_tar_gz
copy_setenv
catalina_out
