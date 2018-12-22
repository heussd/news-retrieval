#!/bin/sh

while :; do
  echo "Copying database..."
  cp -fv /data-to-copy/news.db /data/news.db ;
  newsboat -u /data/urls -d /dev/fd/1 -l 5 -x reload;
  cp -fv /data/news.db /data-to-copy/news.db ;
  echo \"Waiting $RELOAD_EVERY to reload...\" ;
  sleep $RELOAD_EVERY;
done
