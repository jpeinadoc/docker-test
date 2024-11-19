# Usar la imagen base UBI9
FROM registry.access.redhat.com/ubi9/ubi:latest

# Instalar herramientas necesarias
RUN dnf update -y && \
    dnf install -y \
    # gcc: compilador de C necesario para compilar Python y otras bibliotecas C
    gcc \
    # gcc-c++: compilador de C++ necesario para compilar código C++ en caso de que se necesite
    gcc-c++ \
    # make: herramienta para la automatización de la construcción de proyectos (compilación y enlace)
    make \
    # wget: herramienta para descargar archivos desde la web (necesaria para descargar Python)
    wget \
    # git: sistema de control de versiones necesario para gestionar código fuente
    git \
    # libffi-devel: biblioteca que proporciona una interfaz de llamada de función (FFI) para lenguajes de programación
    libffi-devel \
    # zlib-devel: biblioteca de compresión de datos utilizada por Python y otras aplicaciones
    zlib-devel \
    # bzip2-devel: soporte para archivos comprimidos en formato bzip2
    bzip2-devel \
    # ncurses-devel: biblioteca para interfaces de usuario basadas en texto (necesaria para algunas funciones de Python)
    ncurses-devel \
    # xz: utilitario de compresión y descompresión de archivos en formato xz
    xz \
    # xz-devel: bibliotecas de desarrollo necesarias para trabajar con archivos xz
    xz-devel \
    # openssl-devel: biblioteca de cifrado para funciones de seguridad como HTTPS
    openssl-devel \
    # sqlite-devel: soporte para la base de datos SQLite en Python
    sqlite-devel \
    # tar: herramienta para comprimir y descomprimir archivos tar (usada para manejar el archivo de Python)
    tar \
    # patch: herramienta para aplicar parches a archivos de código fuente
    patch \
    # dnf-plugins-core: conjunto de complementos para dnf (gestor de paquetes) que extiende su funcionalidad
    dnf-plugins-core \
    && dnf clean all  # Limpiar la caché de dnf para reducir el tamaño de la imagen

# Descargar y compilar Python 3.13 desde la fuente
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.13.0/Python-3.13.0.tar.xz && \
    tar -xf Python-3.13.0.tar.xz && \
    cd Python-3.13.0 && \
    ./configure --enable-optimizations --with-ensurepip=install --disable-gil && \
    make altinstall && \
    rm -f /usr/src/Python-3.13.0.tar.xz

# Eliminar el enlace simbólico existente para python3 y crear el nuevo
RUN rm -f /usr/bin/python3 && \
    ln -s /usr/local/bin/python3.13 /usr/bin/python3

# Instalar pip
RUN python3.13 -m ensurepip

# Crear un directorio de trabajo
WORKDIR /app

# Copiar el script de verificación (si tienes el script check_gil.py)
COPY check_gil.py .

# Establecer el punto de entrada
CMD ["python3.13", "check_gil.py"]

