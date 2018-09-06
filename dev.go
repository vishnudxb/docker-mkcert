package main

import (
    "net/http"
    "log"
)

func TestServer(w http.ResponseWriter, req *http.Request) {
    w.Header().Set("Content-Type", "text/plain")
    w.Write([]byte("Connected to the Local server.\n"))
}

func main() {
http.HandleFunc("/", TestServer)
    err := http.ListenAndServeTLS(":443", "/tmp/dev.localhost.com.pem", "/tmp/dev.localhost.com-key.pem", nil)
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}
