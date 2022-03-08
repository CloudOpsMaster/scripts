#!/usr/bin/env bash

if [ -s ./settings.cfg ]; 
then
    . ./settings.cfg 
else 
    echo "There no setting.cfg file"
    exit 1 
fi 

app_name=$1

start(){
    cd $tomcatDir/$app_name/bin && sh startup.sh

}

stop(){
  cd $tomcatDir/$app_name/bin && sh shutdown.sh

}

case $2 in
    start)
    echo "Start"
    start
    ;;
    stop)
    echo "Stop"
    stop
    ;;
    restart)
    echo "Restart"
    stop
    start
    ;;
    *)
     echo "Use $0 {app_name start|app_name stop|app_name restart}"
esac

exit 0   