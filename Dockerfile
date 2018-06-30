FROM kd6kxr/hdrmerge-deps:arm32v7-deps2

RUN [ "cross-build-start" ]

#  compile

RUN cd ~/programs/code-hdrmerge/build && cmake /root/programs/code-hdrmerge -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="~/programs/hdrmerge" -DCMAKE_BUILD_TYPE=Release
RUN cd ~/programs/code-hdrmerge/build && make install

RUN [ "cross-build-end" ]

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && ~/programs/hdrmerge/hdrmerge && echo "...THATS ALL FOLKS!!!"
