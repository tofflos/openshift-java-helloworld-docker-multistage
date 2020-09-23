FROM registry.access.redhat.com/ubi8/openjdk-11 as build
COPY ./pom.xml .
RUN mvn dependency:go-offline
COPY ./src ./src
RUN mvn package

FROM registry.access.redhat.com/ubi8/openjdk-11
COPY --from=build /home/jboss/target/helloworld-docker-multistage-1.1.jar /deployments/
COPY --from=build /home/jboss/target/lib /deployments/lib

ENTRYPOINT java -jar /deployments/helloworld-docker-multistage-1.1.jar
EXPOSE 8080