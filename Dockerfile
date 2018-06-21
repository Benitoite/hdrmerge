FROM alpine:latest
CMD echo "This is a test." && ~/programs/hdrmerge/hdrmerge
RUN apk add --no-cache build-base cmake git boost-dev exiv2-dev expat-dev libraw-dev
RUN apk add --no-cache qt5-qtbase-dev zlib-dev
RUN mkdir ~/programs
RUN git clone https://github.com/jcelaya/hdrmerge.git ~/programs/code-hdrmerge
RUN cd ~/programs/code-hdrmerge
RUN ./build-hdrmerge
