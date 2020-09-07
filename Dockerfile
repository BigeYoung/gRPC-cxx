FROM debian:stretch

RUN export MY_INSTALL_DIR=$HOME/.local \
    && mkdir -p $MY_INSTALL_DIR \
    && export PATH="$PATH:$MY_INSTALL_DIR/bin"

RUN apt-get update && apt-get install -y \
  cmake build-essential autoconf git pkg-config \
  automake libtool curl make g++ unzip \
  && apt-get clean \
  && mkdir /grpc

WORKDIR /grpc

# install protobuf first, then grpc
RUN git clone --recurse-submodules -b v1.31.0 https://github.com/grpc/grpc && \
    cd grpc && \
    mkdir -p cmake/build && \
    pushd cmake/build && \
    cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
      ../.. && \
    make -j && \
    make install && \
    popd && \
