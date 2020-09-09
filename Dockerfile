FROM ubuntu:latest

RUN export MY_INSTALL_DIR=$HOME/.local \
    && mkdir -p $MY_INSTALL_DIR \
    && export PATH="$PATH:$MY_INSTALL_DIR/bin"

RUN apt-get update && apt-get install -y \
  cmake build-essential autoconf libtool pkg-config

# install protobuf first, then grpc
RUN git clone --recurse-submodules -b v1.31.0 https://github.com/grpc/grpc \
    && cd grpc \
    && mkdir -p cmake/build \
    && cd cmake/build \
    && cmake -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
        ../..
    && make -j \
    && make install \
    && cd ..
