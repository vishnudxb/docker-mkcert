FROM vishnunair/go-alpine-edge:latest

RUN cd /go && \
    go get -u github.com/FiloSottile/mkcert && \
    cd src/github.com/FiloSottile/mkcert && \
    go build -o /bin/mkcert

WORKDIR /root/.local/share/mkcert

CMD mkcert -install && mkcert $domain && tail -f -n0 /etc/hosts
