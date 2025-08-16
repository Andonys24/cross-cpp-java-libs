FROM alpine:3.22

# Instalar herramientas basicas y toolchains
RUN apk add --no-cache \
    build-base \
    mingw-w64-gcc \
    openjdk21

# Variables de entorno para Java
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Definir directorio de trabajo
WORKDIR /workspace

RUN mkdir -p Win/JNA Win/JNI
RUN mkdir -p Linux/JNA Linux/JNI