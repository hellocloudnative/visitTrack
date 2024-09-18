#!/bin/bash
set -e
realarch=`uname -m`
ip=`hostname -I | cut -d " " -f1`
export GOPROXY=https://goproxy.cn
go version | grep '1.20' || echo "please install golang1.20 manually"
docker version || echo "please install docker manually"
if [ $realarch == "x86_64" ];then
    arch="amd64"
elif [ $realarch == "aarch64" ];then
    arch="arm64"
else
    echo "$realarch is not a supported arch"
    exit 1
fi
rm -rf visittrack

echo "***Starting build visittrack***"
CGO_ENABLED=0 GOOS=linux GOARCH=amd64  go build -o visittrack
version="1.0"
docker buildx build   --platform=linux/amd64  -t visittrack:${version}   .
cd /Users/zhangpengxuan/Downloads; docker save -o visittrack.tar visittrack:${version};cd -