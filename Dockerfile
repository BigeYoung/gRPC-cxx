FROM alpine/git

RUN git clone --recurse-submodules -b v1.34.0 https://github.com/grpc/grpc &&
    ls
    
ENTRYPOINT /bin/sh
