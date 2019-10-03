#!/bin/sh

# Terminate if commands fail
set -e
set -o pipefail

newsDbToCopy=/data-to-copy/news.db

function sqliteintcheck() {
  echo "SQLite integrity check..."
  sqlite3 "$1" "pragma integrity_check;" || echo "FAILED!"
}

function checkextfile() {
  test ! -e "$1" && echo "File not found: $1" && exit 1
  test ! -f "$1" && echo "Error: $1 is not a file. This happens with Docker file mounts if the mounted file did not exist during launch. Please create this file externally and try again." && exit 1
  test ! -w "$1" && echo "No write access: $1" && exit 1
  echo "File checks passed for $1"
}

function wait() {
  echo "Waiting $RELOAD_EVERY to reload..."
  sleep $RELOAD_EVERY
}

newsboat --version
until curl http://fullfeedrss:80 &> /dev/null; do echo "Waiting for fullfeedrss..."; sleep 1; done

while :; do
  #checkextfile $newsDbToCopy
  #cp -fv "$newsDbToCopy" "/data/news.db"

  newsboat -u /data/urls -d /dev/fd/1 -l 4 -x reload;
  newsboat -u /data/urls -d /dev/fd/1 -l 4 -X;

  sqliteintcheck /data/news.db
  #cp -fv "/data/news.db" "$newsDbToCopy"

  wait
done
