FROM debian:10-slim

LABEL authors="zhangpengxuan"

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone

COPY   frontend/src  /frontend/src
COPY   frontend/templates  /frontend/templates
COPY   www         /www
COPY   visittrack  /

ENTRYPOINT ["/visittrack","config.yaml"]