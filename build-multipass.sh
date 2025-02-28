#!/bin/bash
set -e
cd /build/multipass

echo 'Installing dependencies'
mk-build-deps -i --tool="apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes"
rm -f multipass-build-deps*

echo 'Dependencies installed'
mkdir build
cd build
echo 'Building multipass'
cmake -DCMAKE_BUILD_TYPE=Release -DMULTIPASS_ENABLE_TESTS=OFF -DCMAKE_CXX_FLAGS="-O3" ..
make -j$(nproc) multipass
echo 'Multipass built'
