FROM resin/armv7hf-debian-qemu

RUN [ "cross-build-start" ]

#  Add dependencies

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends build-essential cmake git libexiv2-dev expat libraw-dev qt5-default unzip wget bash patch dbus xorg mesa-common-dev mesa-utils zlib1g-dev libalglib-dev -y
RUN mkdir ~/programs && cd ~/programs && git clone https://gitlab.kitware.com/cmake/cmake.git && cd cmake && git checkout v3.4.3 && mkdir ~/programs/cmake/build && cd ~/programs/cmake/build && cmake .. && make && make install


#  Clone GitHub project code

RUN cd ~/programs && git clone https://github.com/jcelaya/hdrmerge.git  ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge

#  compile

RUN cd ~/programs/code-hdrmerge/build && cmake /root/programs/code-hdrmerge -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="~/programs/hdrmerge" -DCMAKE_BUILD_TYPE=Release
RUN cd ~/programs/code-hdrmerge/build && make install

RUN [ "cross-build-end" ]

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && ~/programs/hdrmerge/hdrmerge && echo "...THATS ALL FOLKS!!!"
