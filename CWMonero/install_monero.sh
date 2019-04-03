#!/bin/bash

SOURCE_DIR=`pwd`
EXTERNAL_DIR_PATH="$SOURCE_DIR/External"
EXTERNAL_UTILS_DIR_PATH="`pwd`/../External"
BOOST_URL="https://github.com/fotolockr/ofxiOSBoost.git"
BOOST_DIR_PATH="$EXTERNAL_UTILS_DIR_PATH/ofxiOSBoost"
OPEN_SSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPEN_SSL_DIR_PATH="$EXTERNAL_UTILS_DIR_PATH/OpenSSL"
MONERO_CORE_URL="https://github.com/pyrex-coin/Pyrex-gui.git"
MONERO_CORE_DIR_PATH="$EXTERNAL_DIR_PATH/Pyrex-gui"
MONERO_URL="https://github.com/pyrex-coin/Pyrex.git"
MONERO_DIR_PATH="$MONERO_CORE_DIR_PATH/Pyrex"
SODIUM_URL="https://github.com/jedisct1/libsodium --branch stable"
SODIUM_PATH="$EXTERNAL_DIR_PATH/libsodium"
SODIUM_LIBRARY_PATH="$SODIUM_PATH/libsodium-ios/lib/libsodium.a"
SODIUM_INCLUDE_PATH="$SODIUM_PATH/libsodium-ios/include"

echo "============================ SODIUM ============================"
echo "Cloning SODIUM from - $SODIUM_URL"
git clone -b build $SODIUM_URL $SODIUM_PATH
cd $SODIUM_PATH
./dist-build/ios.sh
cd ../..

echo "============================ Pyrex-gui ============================"

echo "Cloning Pyrex-gui from - $MONERO_CORE_URL"
git clone -b master $MONERO_CORE_URL $MONERO_CORE_DIR_PATH
cd $MONERO_CORE_DIR_PATH
echo "Cloning Pyrex from - $MONERO_URL to - $MONERO_DIR_PATH"
git clone --recursive -b release-v0.13 $MONERO_URL $MONERO_DIR_PATH
echo "Export Boost vars"
export BOOST_LIBRARYDIR="${EXTERNAL_UTILS_DIR_PATH}/ofxiOSBoost/build/ios/prefix/lib"
export BOOST_LIBRARYDIR_x86_64="${EXTERNAL_UTILS_DIR_PATH}/ofxiOSBoost/build/libs/boost/lib/x86_64"
export BOOST_INCLUDEDIR="${EXTERNAL_UTILS_DIR_PATH}/ofxiOSBoost/build/ios/prefix/include"
echo "Export OpenSSL vars"
export OPENSSL_INCLUDE_DIR="${EXTERNAL_UTILS_DIR_PATH}/OpenSSL/include"
export OPENSSL_ROOT_DIR="${EXTERNAL_UTILS_DIR_PATH}/OpenSSL/lib"
export SODIUM_LIBRARY=$SODIUM_LIBRARY_PATH
export SODIUM_INCLUDE=$SODIUM_INCLUDE_PATH
mkdir -p Pyrex/build
./ios_get_libwallet.api.sh
