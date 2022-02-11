#!usr/bin/env bash

check_settings(){
    if [ -s ./settings.cfg ];
    then
        . ./settings.cfg
    else    
        echo "There is no settinggs.cfg"
        exit 1
    fi    
}
check_settings


start(){
    cd $zabbix/sbin
    ./zabbix_agentd
    echo $(cat $PidFile)
}

stop(){
  kill $(cat $PidFile)
}

case $1 in
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
     echo "Use $0 {start|stop|restart}"
esac

exit 0      

