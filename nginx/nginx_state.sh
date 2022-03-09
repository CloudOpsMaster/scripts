#!/usr/bin/env bash


if [ -s ./settings.cfg ];
then 
    . ./settings.cfg 
else 
    echo "File settings does not exist !!!"
    exit 1 
fi         

start(){
    cd $nginx_home/sbin && ./nginx
    echo "$(cat $nginx_home/logs/nginx.pid)"
    echo "nginx begin to run !"
}

stop(){
    cd $nginx_home/sbin && ./nginx -s stop
    echo "nginx stoped !"
}

reload(){
    cd $nginx_home/sbin && ./nginx -s reload 
    echo "nginx reloaded ! "
}

test(){
    cd $nginx_home/sbin && ./nginx -T
}

config(){
   cd  $nginx_home/sbin && ./nginx -V
}

case $1 in 
    start)
    start
    ;;
    stop)
    stop
    ;;
    reload)
    reload
    ;;
    test)
    test
    ;;
    config)
    config
    ;;
    *) 
    echo "use $1 {start|stop|reload|test|config}"
esac
exit 0       
