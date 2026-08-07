FROM dhi.io/jenkins:2.572-debian-dev
USER root
RUN apt-get update && apt-get install -y docker.io && \
    usermod -aG docker jenkins

ARG DOCKER_GID=984
RUN groupadd -g ${DOCKER_GID} docker || groupmod -g ${DOCKER_GID} docker && \
    usermod -aG docker jenkins
USER jenkins