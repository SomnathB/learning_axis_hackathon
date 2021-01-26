FROM registry.access.redhat.com/ubi8/ubi-minimal
LABEL BASE_IMAGE="registry.access.redhat.com/ubi8/ubi-minimal:8.0"
LABEL JAVA_VERSION="1.8"
RUN microdnf install --nodocs java-1.8.0-openjdk-headless && microdnf clean all
RUN mkdir /deployments && chown 1001 /deployments && chmod g+rwX /deployments && chown 1001:root /deployments
COPY target/app.jar /deployments
EXPOSE 8080 8443
USER 1001
ENTRYPOINT [ "java", "-jar", "/deployments/app.jar" ]
