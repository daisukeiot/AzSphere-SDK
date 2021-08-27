#
# Pass variables with --build-arg option
# BASE_IMAGE  : Base Image to install Azure Sphere SDK 
# 
ARG OS_TAG=azsphere-sdk:ubuntu_18.04
FROM ${OS_TAG}

#
# Variables that can be specified with --build-arg option
#
ARG SDK_VERSION=2107_1
ARG SDK_INSTALLER=install_azure_sphere_sdk_${SDK_VERSION}.tar.gz
ARG SDK_INSTALLER_URL=https://software-download.microsoft.com/download/sg/${SDK_INSTALLER}

#
# Run as root to install SDK
#
USER root
WORKDIR /tmp

RUN curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/microsoft-prod.list && \
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    apt-get update

#
# Download SDK
#
RUN curl -LOJ "${SDK_INSTALLER_URL}" && \
    tar -xzf ./*.gz

#
# Switch shell
#
SHELL ["/bin/bash", "-c"] 

#
# Run installer
#
RUN yes y | ./install_azure_sphere_sdk.sh -f
# RUN yes y | ./install_azure_sphere_sdk.sh -f -d
# RUN printf 'Y\n' | ./install_azure_sphere_sdk.sh -f -d
# RUN spawn ./install_azure_sphere_sdk.sh -f -d && \
#     expect "Please check that this fingerprint matches the Microsoft GPG public key fingerprint shown on https://aka.ms/AzureSphereSDKVerification/Linux before proceeding. Do not proceed if these values do not match." && \
#     send "y"

#
# Clean up
#
RUN rm -rf /tmp/*

#
# Switch shell
#
SHELL ["/bin/sh", "-c"] 

ENTRYPOINT []