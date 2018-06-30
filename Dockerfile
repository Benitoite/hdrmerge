FROM resin/raspberrypi3-debian:buster

RUN [ "cross-build-start" ]

#  Add dependencies

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends build-essential cmake git libexiv2-dev expat libraw-dev qt5-default xcb unzip curl bash patch dbus xorg mesa-common-dev mesa-utils zlib1g-dev libalglib-dev -y

RUN [ "cross-build-end" ]

LABEL maintainer="kd6kxr@gmail.com"
