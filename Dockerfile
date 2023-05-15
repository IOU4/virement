FROM gradle:7.6.1-jdk17-alpine as build

WORKDIR /app
COPY ./bff/src ./bff/build.gradle.kts ./bff/
COPY ./build.gradle.kts .
RUN gradle bootjar --no-daemon --exclude-task test

FROM eclipse-temurin:17-jre-alpine as run
WORKDIR /app
COPY --from=build /app/build/libs/bff-0.1.jar .
CMD [ "java", "-jar", "bff-0.1.jar" ]

