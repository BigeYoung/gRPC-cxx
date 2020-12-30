FROM ubuntu:latest

RUN apt-get update && apt-get install -y git

# install protobuf first, then grpc
RUN git clone --recurse-submodules -b v1.34.0 https://github.com/grpc/grpc
