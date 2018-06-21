FROM alpine:latest
CMD echo "This is a test." && ~/programs/hdrmerge/hdrmerge
RUN apk add --no-cache build-base cmake git boost-dev exiv2-dev expat-dev libraw-dev
RUN apk add --no-cache qt5-qtbase-dev zlib-dev unzip wget

RUN mkdir ~/programs

RUN wget http://www.alglib.net/translator/re/alglib-3.14.0.cpp.gpl.zip ~/programs/code-hdrmerge/alglib.zip
RUN unzip ~/programs/code-hdrmerge/alglib.zip /usr/local/include/alglib3

RUN git clone https://github.com/jcelaya/hdrmerge.git ~/programs/code-hdrmerge
RUN cd ~/programs/code-hdrmerge
RUN ./build-hdrmerge
