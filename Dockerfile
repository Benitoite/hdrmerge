FROM alpine:latest

RUN apk add --no-cache build-base cmake git boost-dev exiv2-dev expat-dev libraw-dev qt5-qtbase-dev zlib-dev unzip wget bash

RUN mkdir ~/programs && cd ~/programs
RUN mkdir alglib
RUN wget -O alglib.zip http://www.alglib.net/translator/re/alglib-3.14.0.cpp.gpl.zip && unzip alglib.zip -d ./alglib

RUN git clone https://github.com/jcelaya/hdrmerge.git ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge/build
RUN echo "get a patch"
RUN echo "patch code"
RUN cmake /root/programs/code-hdrmerge/. -DALGLIB_ROOT=~/programs/alglib/cpp  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="~/programs/hdrmerge" -DCMAKE_BUILD_TYPE=Release -DALGLIB_INCLUDES=~/programs/alglib/cpp -DALGLIB_LIBRARIES=~/programs/code-hdrmerge/build
RUN make && make install

CMD echo "This is a test..." && ~/programs/hdrmerge/hdrmerge && echo "...THATS ALL FOLKS!!!"
