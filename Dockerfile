FROM debian:stretch

RUN export MY_INSTALL_DIR=$HOME/.local \
    && mkdir -p $MY_INSTALL_DIR \
    && export PATH="$PATH:$MY_INSTALL_DIR/bin"

RUN apt-get update && apt-get install -y \
  cmake build-essential autoconf git pkg-config python-pip \
  automake libtool curl make g++ unzip libssl-dev libc-ares-dev \
  && pip install absl-py \
  && apt-get clean \
  && mkdir /grpc

WORKDIR /grpc

# install protobuf first, then grpc
RUN git clone --recurse-submodules -b v1.31.0 https://github.com/grpc/grpc \
    && cd grpc \
    && mkdir -p cmake/build \
    && cd cmake/build \
    && cmake -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DgRPC_PROTOBUF_PROVIDER=package \
        -DgRPC_ZLIB_PROVIDER=package \
        -DgRPC_CARES_PROVIDER=package \
        -DgRPC_SSL_PROVIDER=package \
        -DgRPC_ABSL_PROVIDER=package \
        -DCMAKE_BUILD_TYPE=Release \
        ../.. \
    && make -j \
    && make install \
    && cd ..
