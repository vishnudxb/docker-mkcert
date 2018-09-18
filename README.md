## docker-mkcert

Instead of installing mkcert package on my local machine, I prefer to use mkcert as a service.

A docker container running mkcert to have your own valid ssl certificates for your local development container based environment.

#### Create a shared volume between your mkcert & your local container

```

docker volume create --name mkcert-data

```


#### Now run mkcert container with your local domain name. For eg: dev.localhost.com

```

docker run -d -e domain=dev.localhost.com --name mkcert -v mkcert-data:/root/.local/share/mkcert vishnunair/docker-mkcert

```

#### For multiple domains, specify it as an environment variable like below:

```

docker run -d -e domain=api.staging.com,dev.localhost.com,stg.localhost.com --name mkcert -v mkcert-data:/root/.local/share/mkcert vishnunair/docker-mkcert

```

#### Connecting mkcert container with your local development environment.

Once the mkcert is up & running, connect your development environment to the shared volume you create & mount it to the location where you specify your ssl files.  

*For example: I am using a Dockerfile.dev to run a simple http server in go*

*I am mounting /tmp directory to the shared volume because in dev.go file, I specify where to look for the ssl certs.*

```

docker build -f Dockerfile.dev -t=vishnunair/docker-mkcert-dev .

docker run -d -p 443:443 --name mkcert-dev -v mkcert-data:/tmp -it vishnunair/docker-mkcert-dev

```

Now you need to add the mkcert root keys to your system key chain:

For eg: If you're using MAC OSX

```

⇒  mkdir ~/Documents/root-ca ## You create a directory to store your mkcert certificates

⇒  docker cp mkcert:/root/.local/share/mkcert ~/Documents/root-ca ## You copy your mkcert keys from your docker container to your localhost

⇒  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/Documents/root-ca/mkcert/rootCA.pem

```

If everything goes well, You see something like this ![](https://i.imgur.com/R8Ufzjw.png)
