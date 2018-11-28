FROM docker

RUN echo "#!/bin/sh" > /prune.sh \
	&& echo "echo 'looking for log files'" >> /prune.sh \
	&& echo "for vol in \$(docker volume ls | grep logs); do echo \$vol ; docker run --rm -v \$vol:/logs/ alpine find /logs/ -type f -mtime +3 -name '*??-??*' -exec echo \$vol: {} \; -exec rm {} \; ; done" >> /prune.sh \
	&& chmod 755 /prune.sh

CMD ["/prune.sh"]
