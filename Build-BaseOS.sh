if [ $# -ne 2 ]
  then
    echo "======================================="
    echo "Please specify Ubuntu Version and reistry"
    echo "  Registry       : Your registry"
    echo "  Ubuntu Version : 18.04 or 16.04"
    echo ""
    echo "  Example : ${0##*/} myregistry 18.04"
    echo "======================================="
    exit
fi
[ "$DEBUG" ] && set -x
SCRIPT_DIR=$(cd $(dirname $0); pwd)
clear

MY_REGISTRY=$1
OS_VERSION=$2

TAG=${MY_REGISTRY}/azsphere-sdk:ubuntu_${OS_VERSION}

if docker inspect --type=image $TAG > /dev/null 2>&1; then
    echo "Deleting image"
    docker rmi -f ${TAG}
fi

echo ''
echo "██    ██ ██████  ██    ██ ███    ██ ████████ ██    ██ ";
echo "██    ██ ██   ██ ██    ██ ████   ██    ██    ██    ██ ";
echo "██    ██ ██████  ██    ██ ██ ██  ██    ██    ██    ██ ";
echo "██    ██ ██   ██ ██    ██ ██  ██ ██    ██    ██    ██ ";
echo " ██████  ██████   ██████  ██   ████    ██     ██████  ";
echo ''

#
# Build Ubuntu Base Image
#
# docker build --squash --rm \
docker build --rm \
  -f ${SCRIPT_DIR}/BaseOS/Dockerfile \
  --build-arg OS_VERSION=${OS_VERSION} \
  -t ${TAG} \
  ${SCRIPT_DIR}

echo $'\n###############################################################################'
echo " Ubuntu version : ${OS_VERSION}"
echo " Image Tag      : ${TAG}"
echo $'\n###############################################################################\n'
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