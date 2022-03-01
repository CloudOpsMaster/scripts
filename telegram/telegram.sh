#!/usr/bin/env bash



token="$1"
userId="$2"
subj="$3"
message="$4"

curl --header 'Content-Type: application/json' --request 'POST' --data '{"chat_id":'$userId',"text":"'"$subj"'\n'"$message"'"}' "https://api.telegram.org/bot"$token"/sendMessage"

