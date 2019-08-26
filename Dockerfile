FROM alpine:3.8 as dl
ENV ALIYUNCLI_VERSION 3.0.23
WORKDIR /tmp
RUN apk add --no-cache curl \
    && curl -L -o aliyun-cli-linux-amd64.tar.gz https://github.com/aliyun/aliyun-cli/releases/download/v${ALIYUNCLI_VERSION}/aliyun-cli-linux-${ALIYUNCLI_VERSION}-amd64.tgz \
    && tar zxvf aliyun-cli-linux-amd64.tar.gz \
    && mkdir -p /.aliyun

FROM alpine:3.8
COPY --from=dl /tmp/aliyun /usr/local/bin/aliyun
