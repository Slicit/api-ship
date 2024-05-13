# README

## Install & start

Built with:

```docker-engine 20.10.24`

`docker-compose 2.26.0`

First create a `.env` file with the following values:

```env
PG_HOST=your_pg_host
PG_USERNAME=your_pg_user
PG_PASSWORD=your_pg_password
PG_DATABASE=your_pg_database
```

Then you can build and run the docker container

```bash
docker-compose up -d

docker exec api_ship rspec
```