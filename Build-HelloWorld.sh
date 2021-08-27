if [ $# -ne 2 ]
  then
    echo "======================================="
    echo "Please specify Ubuntu Version and reistry"
    echo "  Registry       : Your registry"
    echo "  SDK Image Tag  : Tag of image with Azure Sphere SDK"
    echo ""
    echo "  Example : ${0##*/} myregistry ubuntu_18.04_sdk_2107_1"
    echo "======================================="
    exit
fi
[ "$DEBUG" ] && set -x
SCRIPT_DIR=$(cd $(dirname $0); pwd)
clear

MY_REGISTRY=$1
BASE_TAG=$2

TAG_BASE=${MY_REGISTRY}/azsphere-sdk:${BASE_TAG}
TAG=${MY_REGISTRY}/azsphere-sdk:${BASE_TAG}_helloworld

if docker inspect --type=image $TAG > /dev/null 2>&1; then
    echo "Deleting image"
    docker rmi -f ${TAG}
fi

echo ''
echo '    ____        _ __    __   _____ __             __ '
echo '   / __ )__  __(_) /___/ /  / ___// /_____ ______/ /_'
echo '  / __  / / / / / / __  /   \__ \/ __/ __ `/ ___/ __/'
echo ' / /_/ / /_/ / / / /_/ /   ___/ / /_/ /_/ / /  / /_  '
echo '/_____/\__,_/_/_/\__,_/   /____/\__/\__,_/_/   \__/  '
echo ''
echo "Image Tag        : ${TAG}"
echo "Base Image       : ${TAG_BASE}"
echo ''
#
# Build Hello World Sample
#
docker build --squash --rm -f ${SCRIPT_DIR}/HelloWorld/Dockerfile -t ${TAG} \
  --build-arg TAG_BASE=${TAG_BASE} \
  --no-cache \
  ${SCRIPT_DIR}

echo $'\n###############################################################################'
echo ''
echo "Azure Sphere SDK : ${SDK_VER}"
echo "Image Tag        : ${TAG}"
echo ''
#
# Check if the image exists or not
#
if ! docker inspect --type=image $TAG > /dev/null 2>&1; then
    echo "Failed to create image"
    exit
fi

echo $'\n###############################################################################'
echo 'CTLC+C to cancel docker push'
echo $'###############################################################################\n'
read -t 10
echo "Pushing Image : ${TAG}"
echo ''
docker push ${TAG}

docker create -it --name imagepackage ${TAG} /bin/bash
docker cp imagepackage:/app/HelloWorld_HighLevelApp.imagepackage HelloWorld_HighLevelApp.imagepackage
docker rm -f imagepackage