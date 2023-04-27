# Transactions Api:

## Prerequisites:

  - [Docker](https://www.docker.com/):
      docker is a platform for developing, shipping, and running applications using containerization technology. It allows developers to package their applications and dependencies into lightweight, portable containers that can be run consistently across different environments, from development to production. Docker makes it easier to build, deploy, and manage applications, while also improving scalability and reducing infrastructure costs
  - [Docker Compose](https://docs.docker.com/compose/install/):
      We use Docker Compose in our project to define and run multi-container applications, including our PostgreSQL database and our API. Docker Compose uses a YAML file to specify the configuration for each container, making it easy to spin up and tear down complex environments with a single command.
  - [Docker Buildx](https://docs.docker.com/build/install-buildx/):
      buildx is provided by docker and dedicated to build docker images from a dockerfile we use it in out project to build a docker image for our api from source code.
  - [JDk 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)
      jdk must be installed and configured correctly in the machine to be able to build the jar file with gradle.

## Running Api Services:

first build java jar file with the following command:

```bash
$ ./gradlew api:bootJar
```
here we build the jar file with the name `api` with gradle to be used later in dockerfile to build the image, if we check the directory `build/libs/` there should be a file called `api-0.1.jar` which is the desired spring boot application.

exmaple of successful build: ![bootJar in action](https://raw.githubusercontent.com/IOU4/virement/main/assets/bootJar.png?token=GHSAT0AAAAAAB352HX3VFNVN4IXB2ASXHJ6ZCLCNMA)

next we build the docker image with the following command:
```bash
$ cd api
$ docker buildx build -t eai/api .
```
here we build a docker image with the name `eai/api` using docker buildx to be used later in docker compose file.

here's and exmaple of succeful build: ![docker buildx](https://raw.githubusercontent.com/IOU4/virement/main/assets/buildx.png?token=GHSAT0AAAAAAB352HX3KAIEKMMQ2A6OGZ3KZCLCPDQ)

finally start the services (database and api) with docker compose using the follwing command:
```bash
$ docker compose up -d
```
we use  `-d` flag to detach from terminal, you can if the services are running with following command:
```bash
$ docker ps
```
example of successful run: ![successful compose](https://raw.githubusercontent.com/IOU4/virement/main/assets/compose.png?token=GHSAT0AAAAAAB352HX3KNATE7I5U5G7EMHMZCLCPNA)

great! all is done, now the api should be accessible at: [localhost:8082](http://localhost:8082/)
