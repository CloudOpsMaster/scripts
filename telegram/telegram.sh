#!/usr/bin/env bash



token=""
userId=" "

uptime="$(uptime | cut -c 1-27)"

message="Ubuntu 20.04 \nUptime  $uptime"




curl --header 'Content-Type: application/json' --request 'POST' --data '{"chat_id":'$userId',"text":"'"$message"'"}' "https://api.telegram.org/bot"$token"/sendMessage"

