# Usa una imagen base de Red Hat
FROM registry.access.redhat.com/ubi8/ubi:latest

# Establecer el usuario como root
USER root

RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/product-id.conf
RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/subscription-manager.conf

# Actualiza el sistema e instala las herramientas necesarias
RUN yum install -y python3 python3-pip python3-devel gcc make cyrus-sasl-gssapi krb5-workstation \
    && yum clean all


# Instala las herramientas necesarias y configura el repositorio de Confluent
# Instala las herramientas necesarias
RUN yum install -y gcc gcc-c++ make wget && \
    # Instala librdkafka y sus dependencias de desarrollo
    yum install -y https://packages.confluent.io/rpm/7.7/8/librdkafka1-1.8.2_confluent7.7.1-1.el8.x86_64.rpm && \
    yum install -y https://packages.confluent.io/rpm/7.7/8/librdkafka-devel-1.8.2_confluent7.7.1-1.el8.x86_64.rpm && \
    # Limpia la caché de yum
    yum clean all


RUN yum install -y librdkafka-devel

# Instala confluent-kafka-python como el usuario estándar
RUN python3 -m pip install --no-binary confluent-kafka confluent_kafka==1.8.2

# Verifica que confluent_kafka está instalado
RUN python3 -c 'import confluent_kafka; print(confluent_kafka.version())'

# Cambia a un usuario no root (opcional)
# USER <nombre_de_usuario>

# Comando por defecto al ejecutar el contenedor (puedes cambiarlo según sea necesario)
CMD ["python3"]
