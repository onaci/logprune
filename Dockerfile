FROM docker

RUN echo "#!/bin/sh" > /prune.sh \
	&& echo "for vol in $(docker volume ls | grep logs); do docker run --rm -it -v $vol:/logs/ alpine find /logs/ -type f -mtime +3 -name '*??-??*' -exec echo '$vol: {}' \; ; done > /var/log/cronjob.log" >> /prune.sh \
	&& chmod 755 /prune.sh

CMD ["/prune.sh"]
