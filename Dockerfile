FROM alpine:3.22

# Install basic tools and toolchains
RUN apk add --no-cache \
    build-base \
    mingw-w64-gcc \
    openjdk21

# Environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Define working directory
WORKDIR /workspace

# Create Output folder structure
RUN mkdir -p Win/JNA Win/JNI Linux/JNA Linux/JNI

# Copy script to container with permissions
COPY build.sh /usr/local/bin/build.sh
RUN chmod +x /usr/local/bin/build.sh

# Container waiting or running by default
ENTRYPOINT ["/bin/sh", "/usr/local/bin/build.sh"]
