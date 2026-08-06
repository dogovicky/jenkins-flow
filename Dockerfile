FROM maven:3.9-eclipse-temurin-21 AS builder-base

WORKDIR /build

COPY src/ /build/src/

WORKDIR /app

ENV JAVA_OPTS="\
        -XX:+UseContainerSupport \
        -XX:+MaxRAMPercentage=75.0 \
        -XX:+UseG1GC \
        -Djava.security.egd=file:/dev/./urandom"