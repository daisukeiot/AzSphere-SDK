if [ $# -ne 1 ]
  then
    echo "======================================="
    echo "Please specify your registry"
    echo "  Registry       : Your registry"
    echo ""
    echo "  Example : ${0##*/} myregistry"
    echo "======================================="
    exit
fi

# docker system prune -fa

MY_REGISTRY=$1
UBUNTU_VER=18.04
SDK_VER=2107_1

OS_TAG=ubuntu_${UBUNTU_VER}

./Build-BaseOS.sh ${MY_REGISTRY} ${UBUNTU_VER}
./Build-AzSphereSDK.sh ${MY_REGISTRY} ${OS_TAG} ${SDK_VER}

./Build-HelloWorld.sh ${MY_REGISTRY} ${OS_TAG}_sdk_${SDK_VER}