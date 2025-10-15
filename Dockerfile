FROM debian:12-slim

ENV TRACCAR_VERSION=6.6

WORKDIR /opt/traccar

RUN set -ex; \
    apt-get update; \
    TERM=xterm DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
      openjdk-17-jre-headless \
      unzip \
      wget; \
    wget -qO /tmp/traccar.zip https://github.com/traccar/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip; \
    unzip -qo /tmp/traccar.zip -d /opt/traccar; \
    ls -l /opt/traccar; \
    apt-get autoremove --yes unzip wget; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 8082

# OJO: El nombre del jar puede variar. ¡Revisa el log del comando ls!
CMD ["java", "-Xms128m", "-Xmx256m", "-Djava.net.preferIPv4Stack=true", "-jar", "tracker-server.jar", "conf/traccar.xml"]
