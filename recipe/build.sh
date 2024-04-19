#!/bin/bash

set -ex

mkdir build
cd build
cmake ${CMAKE_ARGS} -G "Ninja" \
      -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
      -DCMAKE_BUILD_TYPE:STRING=Release \
      -DENABLE_TESTS=ON \
      -DCMAKE_LIBRARY_PATH="${PREFIX}/lib" \
      -DCMAKE_INCLUDE_PATH="${PREFIX}/include" \
      -DWITH_FGT="${PREFIX}" \
      -DWITH_JSONCPP=OFF \
      -DWITH_STRICT_WARNINGS=ON \
      ..

ninja
ninja install
if [ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]; then

    echo "Cant run tests because we are cross compiling"
else
    ninja test

fi

