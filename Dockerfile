FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    update-ca-certificates

# Descargar versión estable de Traccar (v6.8)
RUN wget https://github.com/traccar/traccar/releases/download/v6.8/traccar-other-6.8.zip -O /tmp/traccar.zip && \
    unzip /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Exponer puertos
EXPOSE 8082 5055

# Iniciar Traccar
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]
