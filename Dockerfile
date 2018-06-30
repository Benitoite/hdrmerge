FROM kd6kxr/hdrmerge-deps

RUN [ "cross-build-start" ]

#  Clone GitHub project code

RUN cd ~/programs && git clone https://github.com/jcelaya/hdrmerge.git  ~/programs/code-hdrmerge && mkdir ~/programs/code-hdrmerge/build && cd ~/programs/code-hdrmerge

RUN [ "cross-build-end" ]

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
