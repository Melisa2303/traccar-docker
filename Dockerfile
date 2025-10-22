FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    update-ca-certificates

# Descargar versión estable (6.9)
RUN wget https://github.com/traccar/traccar/releases/download/v6.9/traccar-other-6.9.zip -O /tmp/traccar.zip && \
    unzip /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Exponer los puertos necesarios
EXPOSE 8082 5055

# Ejecutar el servidor Traccar
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]

