# Red Hat Decision Manager 

**This project is deprectated. Use project [RHPAM Quickstart](https://github.dev/juliaaano/rhpam-quickstart) instead.**

---

A collection of artifacts to get you started with Red Hat Decision Manager.

## Import and develop in Business Central

Use the URL of this repo in Business Central.

* The rhdm-kjar gets selected for import.
* There is a dependency on **rhdm-dependencies** and **rhdm-event-listener**, but they are available in Maven Central.
* For development, use the SNAPSHOT versions and build dependencies locally.

## Get started

Experiment Decision Manager in two flavors: **JBoss EAP** and **Spring Boot**.

#### JBoss EAP with Docker

```
docker-compose up --detach --force-recreate rhdm-jboss
docker-compose logs --follow rhdm-jboss
curl -i -H 'Authorization: Basic dXNlcjpwYXNzd29yZA==' http://localhost:18080/services/rest/server
```

#### Spring Boot with Docker

```
docker-compose up --detach --force-recreate rhdm-springboot
docker-compose logs --follow rhdm-springboot
curl -i -H 'Authorization: Basic dXNlcjp1c2Vy' http://localhost:18090/rest/server
```

## Build with Docker

Access to **registry.redhat.io** (docker login) is required to build the JBoss image.

```
docker build --file d.jboss.Dockerfile --tag juliaaano/rhdm-jboss .
docker build --file d.springboot.Dockerfile --tag juliaaano/rhdm-springboot .
```

## Postman

Enjoy a setup of automated tests with Postman/Newman.

Use Docker Compose to bring up the containers and then run:

```
POSTMAN_ENV=rhdm-jboss docker-compose run --rm postman
POSTMAN_ENV=rhdm-springboot docker-compose run --rm postman
```

## Install Decision Manager

For the installation of Decision Manager, visit:

* https://github.com/juliaaano/rhdm-eap-ansible

## Develop with Java, Maven and Spring Boot

The rhdm-springboot app is a convenient wat to deploy the kjar and its assets.

See [rhdm-springboot](rhdm-springboot) for more info.
