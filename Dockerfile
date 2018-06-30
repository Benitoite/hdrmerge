FROM kd6kxr/hdrmerge-deps:arm32v7-deps

RUN [ "cross-build-start" ]

#  Build cmake v3.4.3

RUN mkdir ~/programs && cd ~/programs && git clone https://gitlab.kitware.com/cmake/cmake.git && cd cmake && git checkout v3.4.3 && mkdir ~/programs/cmake/build && cd ~/programs/cmake/build && cmake .. && make && make install

#  Clone GitHub project code

RUN cd ~/programs && git clone https://github.com/jcelaya/hdrmerge.git  ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge

RUN [ "cross-build-end" ]

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
