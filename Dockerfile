FROM vishnunair/go-alpine-edge:latest

RUN cd /go && \
    go get -u github.com/FiloSottile/mkcert && \
    cd src/github.com/FiloSottile/mkcert && \
    go build -o /bin/mkcert

ADD . /go

EXPOSE 443

WORKDIR /go

RUN mkcert -install && cp -rvf /go/ssl/*.pem /root/.local/share/mkcert/

CMD mkcert prod.local && go run dev.go
