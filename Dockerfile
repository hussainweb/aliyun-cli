FROM golang:alpine as builder
ENV ALIYUNCLI_VERSION 3.0.27

# We should clone/download the Aliyun CLI in this directory
# as that is what the build scripts expect (relative paths
# to dependencies)
WORKDIR /go/src/github.com/aliyun

RUN apk add --update make git curl
RUN curl -L -o aliyun-cli.tar.gz https://github.com/aliyun/aliyun-cli/archive/v${ALIYUNCLI_VERSION}.tar.gz \
    && tar zxvf aliyun-cli.tar.gz \
    && mv aliyun-cli-${ALIYUNCLI_VERSION} aliyun-cli
# Instead of the above, we can also:
# git clone --branch v${ALIYUNCLI_VERSION} https://github.com/aliyun/aliyun-cli.git 

WORKDIR /go/src/github.com/aliyun/aliyun-cli
RUN make build

FROM alpine:3.10
COPY --from=builder /go/src/github.com/aliyun/aliyun-cli/out/aliyun /usr/local/bin/aliyun
