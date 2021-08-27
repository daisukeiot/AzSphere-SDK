#
# Ubuntu Version
#
ARG OS_VERSION=18.04
FROM ubuntu:${OS_VERSION}

ARG OS_VERSION=18.04
ENV TZ=US/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/time
#
# Run as root user
#
USER root
WORKDIR /tmp

#
# Create user `azsphere`
#
# RUN useradd -ms /bin/bash azsphere && \
#     chown azsphere -R /home/azsphere

SHELL ["/bin/bash", "-c"] 

#
# Install libraries
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                net-tools \
                lsb-release \
                ca-certificates \
                gpg \
                gpg-agent \
                xz-utils \
                findutils \
                expect \
                sudo \
                udev \
                file \
                libcap2-bin \
                cmake \
                ninja-build \
                git \
                curl && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#
#
# USER azsphere
# WORKDIR /home/azsphere

ENTRYPOINT []