FROM ubuntu:latest

#  Add dependencies

RUN apt-get update && yes|apt-get install build-essential cmake git libexiv2-dev expat libraw-dev qt5-default unzip wget bash patch dbus xorg mesa-common-dev mesa-utils zlib1g-dev

#  Clone GitHub project code

RUN mkdir ~/programs && cd ~/programs && git clone https://github.com/jcelaya/hdrmerge.git  ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge

#  compile

RUN cd ~/programs/code-hdrmerge/build && cmake /root/programs/code-hdrmerge -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="~/programs/hdrmerge" -DCMAKE_BUILD_TYPE=Release
RUN cd ~/programs/code-hdrmerge/build && make install

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && ~/programs/hdrmerge/hdrmerge && echo "...THATS ALL FOLKS!!!"
