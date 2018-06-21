FROM alpine:latest
CMD echo "This is a test." && ~/programs/hdrmerge/hdrmerge
RUN apk add --update build-essential cmake git libalglib-dev libboost-all-dev libexiv2-dev libexpat-dev libraw-dev qt5-default zlib1g-dev
RUN mkdir ~/programs
RUN git clone https://github.com/jcelaya/hdrmerge.git ~/programs/code-hdrmerge
RUN cd ~/programs/code-hdrmerge
RUN ./build-hdrmerge
