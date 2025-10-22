FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    update-ca-certificates

# Descargar e instalar la última versión de Traccar
RUN wget --no-verbose --show-progress --progress=dot:giga \
    https://github.com/traccar/traccar/releases/latest/download/traccar-other.zip -O /tmp/traccar.zip && \
    unzip /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Exponer puertos
EXPOSE 8082 5055

CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]
