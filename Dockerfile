FROM docker

RUN echo "#!/bin/sh" > /prune.sh \
	&& echo "echo 'looking for log files'" >> /prune.sh \
	&& echo "for vol in $(docker volume ls | grep logs); do echo $vol ; docker run --rm -it -v $vol:/logs/ alpine find /logs/ -type f -mtime +3 -name '*??-??*' -exec echo '$vol: {}' \; ; done" >> /prune.sh \
	&& chmod 755 /prune.sh

CMD ["/prune.sh"]
