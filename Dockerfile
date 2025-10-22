# Imagen base ligera de OpenJDK
FROM openjdk:17-jdk-slim

# Directorio de trabajo
WORKDIR /opt/traccar

# Descargar e instalar Traccar Server versión 6.7 (ajustado a la nueva URL)
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://github.com/traccar/traccar/releases/latest/download/traccar-other.zip -O /tmp/traccar.zip && \
    unzip /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Exponer puertos: interfaz web (8082) y protocolo GPS (5055)
EXPOSE 8082 5055

# Comando de ejecución
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]
