FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY  ./build/libs/bff-0.1.jar .

# install rhsso certificate
USER root
COPY ./rhsso.cer $JAVA_HOME/lib/security
COPY ./ingressoperator.cer $JAVA_HOME/lib/security
WORKDIR  $JAVA_HOME/lib/security
RUN keytool -keystore cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias rhssocert -file rhsso.cer
RUN keytool -keystore cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ingressoperator -file ingressoperator.cer

WORKDIR /app

CMD [ "java", "-jar", "bff-0.1.jar" ]
