FROM alpine:latest

RUN apk add --no-cache build-base cmake git boost-dev exiv2-dev expat-dev libraw-dev qt5-qtbase-dev zlib-dev unzip wget bash patch

RUN mkdir ~/programs && cd ~/programs && mkdir alglib && wget -O alglib.zip http://www.alglib.net/translator/re/alglib-3.14.0.cpp.gpl.zip && unzip alglib.zip -d ./alglib

RUN cd ~/programs && git clone https://github.com/jcelaya/hdrmerge.git ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge
RUN cd ~/programs/code-hdrmerge && wget -O docker-cmake.diff  https://raw.githubusercontent.com/Benitoite/hdrmerge/dock1/docker-cmake.diff
RUN cd ~/programs/code-hdrmerge && pwd && ls -la
RUN patch ~/programs/code-hdrmerge/CMakeLists.txt < ~/programs/code-hdrmerge/docker-cmake.diff
RUN cd ~/programs/code-hdrmerge/build && cmake /root/programs/code-hdrmerge/. -DALGLIB_ROOT=~/programs/alglib/cpp  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="~/programs/hdrmerge" -DCMAKE_BUILD_TYPE=Release -DALGLIB_INCLUDES=~/programs/alglib/cpp -DALGLIB_LIBRARIES=~/programs/code-hdrmerge/build
RUN cd ~/programs/code-hdrmerge/build && make install

CMD echo "This is a test..." && ~/programs/hdrmerge/hdrmerge && echo "...THATS ALL FOLKS!!!"
