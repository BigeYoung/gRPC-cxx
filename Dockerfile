FROM debian:stretch

RUN apt-get update && apt-get install -y \
  cmake build-essential autoconf git pkg-config \
  automake libtool curl make g++ unzip \
  && apt-get clean

# install protobuf first, then grpc
ENV GRPC_RELEASE_TAG v1.31.0
RUN git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc && \
		cd /var/local/git/grpc && \
    git submodule update --init && \
    mkdir build && \
    cd build && \
    cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      .. \
    && make -j$(nproc) \
    && make install \
    && make clean && ldconfig
