FROM	alpine/git as git
WORKDIR	/cloned
RUN		git clone --depth 1 https://github.com/heussd/dotfiles . 


FROM	heussd/newsboat
RUN 	apk add --no-cache --update \
            bash \
            curl \
            sqlite

WORKDIR	/root/
COPY	config /etc/newsboat/config
COPY    --from=git /cloned/.config/newsboat/scripts/full-text-feed ./
COPY    retrieve ./
RUN		chmod -Rfv 755 full-text-feed retrieve


ENV		RELOAD_EVERY=3h
ENV     FIVE_FILTERS_SERVICE=fulltextfeed

ENTRYPOINT [ "/root/retrieve" ]

