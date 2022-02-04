FROM mono:latest

MAINTAINER David Calvert <dcalvert2014@gmail.com>

RUN apt-get update && apt-get install	\
	wget				\
	unzip				&& \
	apt-get clean

RUN mkdir -p /data/ksp	&&	\
	useradd -u 1000 -s /bin/bash -d /data/ksp ksp	&& \
	chown ksp:ksp /data/ksp

ADD ksp.sh /usr/local/bin/ksp

EXPOSE 6702

USER ksp

ENV SERVER_REMOTE_FILE	https://d-mp.org/builds/release/v0.3.8.2/DMPServer.zip

RUN cd /data/ksp && wget ${SERVER_REMOTE_FILE} && unzip DMPServer.zip	

RUN mkdir -p /data/ksp/DMPServer/Universe && mkdir -p /data/ksp/config && mkdir -p /data/ksp/DMPServer/logs && mkdir -p /data/ksp/kspconfig

COPY config/*.txt /data/ksp/kspconfig/

VOLUME [ "/data/ksp/DMPServer/Universe", "/data/ksp/config", "/data/ksp/DMPServer/logs" ]
WORKDIR /data/ksp

CMD ["ksp"]
