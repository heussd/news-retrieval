# newsboat RSS Client
# "The Mutt of the RSS clients"

# Important files are
# /data/urls
# /data-to-copy/news.db
# /data/news.db.lock
# /data/news.error.log
FROM	alpine
RUN 	apk add --update newsboat

RUN 	mkdir /root/.newsboat /data

WORKDIR	/root/
COPY	config /root/.newsboat/

COPY	fulltextfeed .
RUN		chmod -Rfv 755 fulltextfeed

COPY		newsboat-data-to-copy.sh .
ENTRYPOINT	["./newsboat-data-to-copy.sh"]

# How often RSS feeds are queried, time in $(sleep)-format
ENV		RELOAD_EVERY=20m
