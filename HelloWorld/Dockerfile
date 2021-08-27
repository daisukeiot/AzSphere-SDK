#
# Pass variables with --build-arg option
# TAG_BASE  : Base OS Image
# 
ARG TAG_BASE=azsphere-sdk:ubuntu_18.04
#
# Image with Azure Sphere SDK
#
FROM ${TAG_BASE}

#
# Switch shell
#
SHELL ["/bin/bash", "-c"] 

#
# Build Hello World sample
#
WORKDIR /AzSphere
RUN git clone https://github.com/Azure/azure-sphere-samples.git && \
    cd azure-sphere-samples/Samples/HelloWorld/HelloWorld_HighLevelApp && \
    ls && \
    mkdir build && \ 
    cd build && \
    cmake \
        -G "Ninja" \
        -DCMAKE_TOOLCHAIN_FILE="/opt/azurespheresdk/CMakeFiles/AzureSphereToolchain.cmake" \
        -DAZURE_SPHERE_TARGET_API_SET="latest-lts" \
        -DCMAKE_BUILD_TYPE="Debug" \
        /AzSphere/azure-sphere-samples/Samples/HelloWorld/HelloWorld_HighLevelApp && \
    ninja && \
    mkdir /app && \
    cp *.imagepackage /app

WORKDIR /app
RUN ls -la
