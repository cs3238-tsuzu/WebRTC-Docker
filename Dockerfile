FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y git \
	vim \
	curl \
	g++ \
	sudo \
	python \
	xz-utils \
	bzip2 \
	lsb-core

RUN cd /root &&  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH $PATH:/root/depot_tools
RUN cd /root/ && mkdir webrtc-checkout && cd webrtc-checkout && fetch --nohooks webrtc && gclient sync
RUN DEBIAN_FRONTEND=noninteractive cd /root/webrtc-checkout/src/ && yes | ./build/install-build-deps.sh --no-prompt
RUN cd /root/webrtc-checkout/src/ && gn gen out/Default
RUN cd /root/webrtc-checkout/src/ && ninja -C out/Default

