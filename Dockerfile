FROM alpine:3.11.6

ENV GOPATH /go

COPY . /go/src/github.com/hound-search/hound

RUN apk update \
	&& apk add go git subversion libc-dev mercurial openssh \
	&& go get github.com/fsnotify/fsnotify \
	&& go install github.com/hound-search/hound/cmds/houndd \
	&& apk del go \
	&& rm -f /var/cache/apk/* \
	&& rm -rf /go/src /go/pkg

VOLUME ["/data"]

EXPOSE 6080

ENTRYPOINT ["/go/bin/houndd", "-conf", "/data/config.json"]
