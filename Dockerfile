FROM kd6kxr/hdrmerge-64deps2:aarch64-deps2

RUN [ "cross-build-start" ]

#  compile

RUN mkdir /programs && cd ~/programs/code-hdrmerge/build && cmake /root/programs/code-hdrmerge -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="/programs" -DCMAKE_BUILD_TYPE=Release
RUN cd ~/programs/code-hdrmerge/build && make install && chmod 777 /programs/hdrmerge

RUN [ "cross-build-end" ]

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && /programs/hdrmerge && echo "...THATS ALL FOLKS!!!"
