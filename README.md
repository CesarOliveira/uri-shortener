# Shortener

### Live Example

You can check here the live exemplo: [http://shortener.cesaroliveira.com.br/](http://shortener.cesaroliveira.com.br/ "http://shortener.cesaroliveira.com.br/")



### Prerequisites

- You need to have docker installed in your machine;
- Check Docker Documentation to install it https://docs.docker.com/install/;

## Bulding the Application
First you need to  up the docker application with:

```
docker-compose up -d
```
In the first time all the images will be builded.

After that you need to create the databse:
```
docker exec -it api-shortener rake db:create db:migrate
```

If you want, you can populate the database with:
```
docker exec -it api-shortener rake db:seed
```

Configure in your /etc/hosts file the entries for a better experience
```
127.0.0.1 api-shortener.local
127.0.0.1 client-shortener.local
```

Now just access: [http://client-shortener.local/](http://client-shortener.local/ "Client URL") or [http://localhost:8080/](http://localhost:8080/ "Client URL") if you not configured the hosts above


## Using the API

### Creating the First Link with CURL

A curl example to create a new shortened link:
```shell
curl --location --request POST 'http://localhost:3001/api/links' \
--header 'Content-Type: application/json' \
--data-raw '{
    "link": {
    "destination_url": "http://gmail.com.br"
    }
}'
```

I also add in this repository the [Shortener.postman_collection.json](https://github.com/CesarOliveira/uri-shortener/blob/master/Shortener.postman_collection.json "Shortener.postman_collection.json") file that you can import in Postman app and see all the routes available.

Tip: How to import a collection in Postman: https://www.youtube.com/watch?v=hMbF3fZitic
