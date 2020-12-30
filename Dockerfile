FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN export MY_INSTALL_DIR=$HOME/.local \
    && mkdir -p $MY_INSTALL_DIR \
    && export PATH="$PATH:$MY_INSTALL_DIR/bin"

RUN apt-get update && apt-get install -y \
  git cmake build-essential autoconf libtool pkg-config \
  libprotoc-dev protobuf-c-compiler protobuf-compiler-grpc

# install protobuf first, then grpc
RUN git clone --recurse-submodules -b v1.34.0 https://github.com/grpc/grpc
