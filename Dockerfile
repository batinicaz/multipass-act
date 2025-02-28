FROM catthehacker/ubuntu:act-24.04 AS builder

RUN apt-get update && apt-get install -y build-essential cmake curl devscripts equivs

WORKDIR /build

RUN git clone https://github.com/canonical/multipass.git && \
    cd multipass && \
    git checkout stable && \
    git submodule update --init --recursive

COPY build-multipass.sh /build/

RUN ./build-multipass.sh

FROM catthehacker/ubuntu:act-24.04

RUN apt-get update && apt-get install -y \
    libgl1 libpng16-16 libqt6core6 libqt6gui6 \
    libqt6network6 libqt6widgets6 libxml2 libvirt0 \
    dnsmasq-base dnsmasq-utils qemu-system-x86 qemu-utils \
    libslang2 iproute2 iptables iputils-ping libatm1 \
    libxtables12 xterm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/multipass/build/bin/multipass /usr/local/bin/multipass
