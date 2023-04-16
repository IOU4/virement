# Virement API

This project provides an API for managing transactions.

## Building the Docker Image

To build the Docker image for the API, run the following command:

```bash
$ ./gradlew bootBuildImage
```

This command will create a Docker image for the API, which includes the application code, its dependencies, and a JRE.

## Running the API

To run the API, you can use Docker Compose. Docker Compose allows you to define and run multi-container Docker applications.

Before running Docker Compose, make sure that you have built the Docker image for the API using the ./gradlew bootBuildImage command.

To start the API, run the following command:

```bash
docker-compose up -d
```

This command will start the API in the background, and you should be able to access it on http://localhost:8080.

## API Endpoints

The API provides the following endpoints:
```
--
```
For more information on how to use these endpoints, please refer to the API documentation.

## API Documentation

```
--
```
## Configuration

The API can be configured using environment variables. The following environment variables are supported:

    DB_PORT : The port to use for  the database . Defaults to 5432
    DB_USER: The username to use when connecting to the database. Defaults to eai.
    DB_PASS: The password to use when connecting to the database. Defaults to 'secret'.

You can set these environment variables when running the API using Docker Compose. For example, to set the DATABASE_URL environment variable, you can add the following line to a `db.env` file

```bash
  DB_PORT=8088
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.
