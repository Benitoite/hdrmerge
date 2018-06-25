FROM alpine:latest

#  Add dependencies

RUN apk add --no-cache build-base cmake git boost-dev exiv2-dev expat-dev libraw-dev qt5-qtbase-dev zlib-dev unzip wget bash patch dbus mesa-dri-swrast mesa mesa-gl xorg-server

#  Get alglib sourcecode

RUN mkdir ~/programs && cd ~/programs && mkdir alglib && wget -O alglib.zip http://www.alglib.net/translator/re/alglib-3.14.0.cpp.gpl.zip && unzip alglib.zip -d ./alglib

#  Clone GitHub project code

RUN cd ~/programs && git clone https://github.com/jcelaya/hdrmerge.git  ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge

#  patch CMakeLists.txt for alglib support

RUN cd ~/programs/code-hdrmerge && wget -O docker-cmake.diff https://raw.githubusercontent.com/Benitoite/hdrmerge/dock1/docker-cmake.diff
RUN patch ~/programs/code-hdrmerge/CMakeLists.txt < ~/programs/code-hdrmerge/docker-cmake.diff

#  compile

RUN cd ~/programs/code-hdrmerge/build && cmake /root/programs/code-hdrmerge -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DALGLIB_ROOT=~/programs/alglib/cpp  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="~/programs/hdrmerge" -DCMAKE_BUILD_TYPE=Release -DALGLIB_INCLUDES=~/programs/alglib/cpp
RUN cd ~/programs/code-hdrmerge/build && make install

#   set entrypoint cmd

CMD echo "This is a test..." && ~/programs/hdrmerge/hdrmerge && echo "...THATS ALL FOLKS!!!"
