FROM resin/aarch64-debian:sid

RUN [ "cross-build-start" ]

#  Add dependencies

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends apt-utils build-essential software-properties-common cmake git libexiv2-dev expat libraw-dev qt5-default xcb libx11-xcb1 unzip curl bash patch dbus xorg-dev mesa-common-dev mesa-utils zlib1g-dev libalglib-dev qtbase5-private-dev libxcb1-dev libx11-dev qtbase5-dev libudev-dev xvfb -y

RUN [ "cross-build-end" ]

LABEL maintainer="kd6kxr@gmail.com"
