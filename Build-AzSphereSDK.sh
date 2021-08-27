if [ $# -ne 3 ]
  then
    echo "======================================="
    echo "Please specify Ubuntu Version and reistry"
    echo "  Registry       : Your registry"
    echo "  OS Tag         : Tag of image to install Azure Sphere SDK"
    echo "  SDK Version    : SDK Version string"
    echo ""
    echo "  Example : ${0##*/} myregistry ubuntu_18.04 2107_1"
    echo "======================================="
    exit
fi
[ "$DEBUG" ] && set -x
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# clear

MY_REGISTRY=$1
BASE_TAG=$2
SDK_VER=$3

TAG_BASE=${MY_REGISTRY}/azsphere-sdk:${BASE_TAG}
TAG=${MY_REGISTRY}/azsphere-sdk:${BASE_TAG}_sdk_${SDK_VER}

if docker inspect --type=image $TAG > /dev/null 2>&1; then
    echo "Deleting image"
    docker rmi -f ${TAG}
fi

echo ''
echo " █████  ███████ ██    ██ ██████  ███████     ███████ ██████  ██   ██ ███████ ██████  ███████ ";
echo "██   ██    ███  ██    ██ ██   ██ ██          ██      ██   ██ ██   ██ ██      ██   ██ ██      ";
echo "███████   ███   ██    ██ ██████  █████       ███████ ██████  ███████ █████   ██████  █████   ";
echo "██   ██  ███    ██    ██ ██   ██ ██               ██ ██      ██   ██ ██      ██   ██ ██      ";
echo "██   ██ ███████  ██████  ██   ██ ███████     ███████ ██      ██   ██ ███████ ██   ██ ███████ ";
echo "                                                                                             ";
echo ""
echo "Image Tag        : ${TAG}"
echo "Base Image       : ${TAG_BASE}"
echo "Azure Sphere SDK : ${SDK_VER}"
echo ''
#
# Install Azure Sphere SDK to Ubuntu Base Image
#
# docker build --squash --rm -f ${SCRIPT_DIR}/AzSphereSDK/Dockerfile -t ${TAG} \
docker build --rm -f ${SCRIPT_DIR}/AzSphereSDK/Dockerfile -t ${TAG} \
  --build-arg SDK_VERSION=${SDK_VER} \
  --build-arg OS_TAG=${TAG_BASE} \
  ${SCRIPT_DIR}

echo $'\n####################################################################################'
echo "Azure Sphere SDK : ${SDK_VER}"
echo "Image Tag        : ${TAG}"
echo $'\n####################################################################################'
#
# Check if the image exists or not
#
if ! docker inspect --type=image $TAG > /dev/null 2>&1; then
    echo "Failed to create image"
    exit
fi

# echo $'\n###############################################################################'
# echo 'CTLC+C to cancel docker push'
# echo $'###############################################################################\n'
# read -t 10
# echo "Pushing Image : ${TAG}"
# echo ''
# docker push ${TAG}