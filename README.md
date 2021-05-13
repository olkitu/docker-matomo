# Matomo Alpine & Nginx & Supervisor

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/olkitu/docker-matomo) ![Docker Pulls](https://img.shields.io/docker/pulls/olkitu/docker-matomo)

Based Official Matomo Alpine image: https://hub.docker.com/_/matomo

This is Matomo installation with few features:

* Build to Swarm environment without persistent volumes
* Added more environment variables

## Deploy

This is recommend deploy to Docker Swarm but you can also deploy this locally.

```yml
version: "3"
services:
  matomo:
    image: olkitu/docker-matomo
    deploy:
      replicas: 1
      update_config:
        delay: 10s
        failure_action: pause
        monitor: 1m
        order: start-first
      restart_policy:
        condition: on-failure
    ports:
      - 8080:80
    environment:
      MATOMO_DATABASE_HOST: db
      MATOMO_DATABASE_ADAPTER: mysql
      MATOMO_DATABASE_TABLES_PREFIX: matomo_
      MATOMO_DATABASE_USERNAME: matomo
      MATOMO_DATABASE_PASSWORD: matomo
      MATOMO_DATABASE_DBNAME: matomo
      MATOMO_DATABASE_CHARSET: utf8mb4
      MATOMO_FORCE_SSL: 1
      MATOMO_USE_SSL: 1
      # If behind of Reverse Proxy
      MATOMO_ASUME_SECURE_PROTOCOL: 1
      MATOMO_PROXY_CLIENT_HEADERS: HTTP_X_FORWARDED_FOR
      MATOMO_SALT: changeme
      # Email Configuration
      MATOMO_MAIL_TRANSPORT: smtp
      MATOMO_MAIL_PORT: 587
      MATOMO_MAIL_HOST:
      MATOMO_MAIL_TYPE: Login
      MATOMO_MAIL_USERNAME:
      MATOMO_MAIL_PASSWORD:
      MATOMO_MAIL_ENCRYPTION: tls
```

Copy this example to `matomo-deploy.yml` and deploy to Docker Swarm

```
docker-compose stack deploy -c matomo-deploy.yml docker-matomo
```

After stack deployment you can import the `matomo-schema.sql` and `matomo-test-data.sql` to create user account and test site.

## Default Admin User

In test schema will create admin user and import test site. Please remove this if you will use this in production.

admin / Qwerty1234

## Develop & Testing

Copy `.env.example` to `.env` and setup the environment variables.

You can then use `docker-compose.yml` in this repository to build and test.