FROM gradle:jdk21-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon --stacktrace --debug

FROM eclipse-temurin:21.0.2_13-jre-alpine
EXPOSE 8080/tcp
RUN mkdir /app && apk -U upgrade && apk add --no-cache tini \
&& addgroup -S demo && adduser -S demo -s /sbin/nologin -G demo --no-create-home && update-ca-certificates \
&& apk --purge del libgcc libstdc++ ca-certificates apk-tools \
&& rm -rf /tmp/* /var/cache/apk/ /var/cache/misc /root/.gnupg /root/.cache /root/go /etc/apk

COPY --from=build /home/gradle/src/build/libs/*.war /app/demo.war
RUN chown -R demo:demo /app && chmod -R g+w /app

HEALTHCHECK --interval=3s --timeout=1s \
CMD ["/usr/bin/nc", "-vz", "-w1", "127.0.0.1", "8080"]

LABEL description="Demo Java (Spring Framework) application for microservice architecture💾" \
      maintainer="ammnt <admin@msftcnsi.com>" \
      org.opencontainers.image.description="Demo Java (Spring Framework) application for microservice architecture💾" \
      org.opencontainers.image.authors="ammnt, admin@msftcnsi.com" \
      org.opencontainers.image.title="Demo Java (Spring Framework) application for microservice architecture💾" \
      org.opencontainers.image.source="https://github.com/ammnt/demo"

ENTRYPOINT [ "/sbin/tini", "--" ]
USER demo
CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseContainerSupport", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/demo.war"]
