FROM ubuntu:22.04
COPY Dockerfile.ubuntu /Dockerfile.ubuntu
RUN apt-get update && apt-get install -y wget unzip
RUN wget https://github.com/traccar/traccar/releases/download/v6.7/traccar-other-6.7.zip -O /tmp/traccar.zip \
    && unzip /tmp/traccar.zip -d /opt/traccar \
    && rm /tmp/traccar.zip
EXPOSE 8082 5055
WORKDIR /opt/traccar
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]
