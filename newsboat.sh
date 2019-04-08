#!/bin/sh

newsDbToCopy=/data/news.db

if [ ! -w "$newsDbToCopy" ]; then
   echo "No write access to file $newsDbToCopy"
   exit 1
fi

dockerize -wait http://fullfeedrss:80
if [ $? -ne 0 ]; then exit 1; fi

while :; do
  newsboat -u /data/urls -d /dev/fd/1 -l 5 -x reload;

  cp -fv /data/news.db /data/news.bck.db;

  echo \"Waiting $RELOAD_EVERY to reload...\" ;
  sleep $RELOAD_EVERY;
done
