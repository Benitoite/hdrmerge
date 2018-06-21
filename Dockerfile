FROM alpine:latest
CMD echo "This is a test." && ~/programs/hdrmerge/hdrmerge
RUN apk add --no-cache build-base cmake git boost-dev exiv2-dev expat-dev libraw-dev
RUN apk add --no-cache qt5-qtbase-dev zlib-dev unzip wget

RUN mkdir ~/programs && cd ~/programs

RUN wget -O ~/programs/alglib.zip http://www.alglib.net/translator/re/alglib-3.14.0.cpp.gpl.zip
RUN unzip ~/programs/alglib.zip -d ./alglib
RUN mkdir /usr/local/include/alglib3
RUN cp -r ~/programs/alglib/cpp /usr/local/include/alglib3

RUN git clone https://github.com/jcelaya/hdrmerge.git ~/programs/code-hdrmerge
RUN cd ~/programs/code-hdrmerge
RUN ./build-hdrmerge
