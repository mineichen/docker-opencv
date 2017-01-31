FROM debian:jessie
MAINTAINER Markus Ineichen "markus_ineichen@gmx.ch"

ARG OPENCV_VERISON="3.2.0"

RUN apt-get update \
  && apt-get install -y pkg-config curl build-essential checkinstall cmake \
  && curl -sL https://github.com/opencv/opencv/archive/${OPENCV_VERISON}.tar.gz | tar xvz -C /tmp \
  && mkdir -p /tmp/opencv-$OPENCV_VERISON/build \
  && cd /tmp/opencv-$OPENCV_VERISON/build \
  && cmake -D WITH_OPENCL=OFF -DWITH_OPENEXR=OFF -DBUILD_TIFF=OFF -DWITH_CUDA=OFF .. \
  && make && make install \
  && echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf \
  && ldconfig \
  && apt-get autoclean && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && addgroup opencv \
  && adduser --ingroup opencv --system opencv 

WORKDIR /home/opencv
CMD ["bash"]
