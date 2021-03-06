# This Dockerfile is divided in two stages, the first is a builder for the KJAR
# and the second is the executable image (KIE Server + KJAR).
# Maven 'dependency:go-offline' followed by '--offline install' is used to leverage
# the Docker caching so builds are faster after the first time.


### BUILDER IMAGE ###
FROM maven:3-jdk-8-slim as builder

COPY rhdm-dependencies/pom.xml /build/rhdm-dependencies/
RUN mvn --file build/rhdm-dependencies/pom.xml --batch-mode install

COPY rhdm-event-listener/pom.xml /build/rhdm-event-listener/
RUN mvn --file build/rhdm-event-listener/pom.xml --batch-mode dependency:go-offline
# dependency:go-offline does not resolve transitive BOM (from drools-bom), therefore 'install'is required.
RUN mvn --file build/rhdm-event-listener/pom.xml --batch-mode install

COPY rhdm-event-listener/src /build/rhdm-event-listener/src/
RUN mvn --file build/rhdm-event-listener/pom.xml --batch-mode --offline install -DskipTests

COPY rhdm-kjar/pom.xml /build/rhdm-kjar/
RUN mvn --file build/rhdm-kjar/pom.xml --batch-mode dependency:go-offline

COPY rhdm-kjar/src /build/rhdm-kjar/src/
RUN mvn --file build/rhdm-kjar/pom.xml --batch-mode --offline install -DskipTests


### EXECUTABLE IMAGE ###
FROM registry.redhat.io/rhdm-7/rhdm-kieserver-rhel8:7.6.0

COPY --from=builder /root/.m2/repository /home/jboss/.m2/repository/

USER root
RUN chown jboss -R /home/jboss/.m2/repository
USER jboss

ENV KIE_ADMIN_USER=user KIE_ADMIN_PWD=password
ENV KIE_SERVER_CONTAINER_DEPLOYMENT=rhdm-quickstart=com.juliaaano:rhdm-kjar:1.0.2-SNAPSHOT
