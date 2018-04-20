FROM nvidia/cuda-ppc64le:9.0-cudnn7-runtime-centos7
MAINTAINER H2o.ai <ops@h2o.ai>

RUN yum -y install yum-plugin-ovl && \
    yum -y update && \
    yum -y install java sudo zip curl epel-release && \
    yum update && \
    yum -y install nginx

RUN curl https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/rel-1.1.0-5/ppc64le-centos7/dai-1.1.0-1.ppc64le.rpm  --output dai-1.1.0-1.ppc64le.rpm && \
    rpm -ivh dai-1.1.0-1.ppc64le.rpm

RUN curl -H 'Cache-Control: no-cache' \
    https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
    | bash

EXPOSE 22
EXPOSE 12345
EXPOSE 54321

COPY run-dai-nimbix.sh /run-dai-nimbix.sh

# Nginx Configuration
COPY NAE/nginx.conf /etc/nginx/conf.d/default.conf
COPY NAE/default /etc/nginx/sites-enabled/default

# Nimbix Integrations
COPY NAE/url.txt /etc/NAE/url.txt
COPY NAE/help.html /etc/NAE/help.html
COPY NAE/AppDef.json /etc/NAE/AppDef.json
COPY NAE/AppDef.png /etc//NAE/default.png
COPY NAE/screenshot.png /etc/NAE/screenshot.png
