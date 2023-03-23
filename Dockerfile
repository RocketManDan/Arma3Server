FROM debian:bullseye-slim

LABEL maintainer="Dan - github.com/rocketmandan"
LABEL org.opencontainers.image.source=https://github.com/rocketmandan/arma3server

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
    && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        python3 \
        lib32stdc++6 \
        lib32gcc-s1 \
        libcurl4 \
        wget \
        ca-certificates \
    && \
    apt-get remove --purge -y \
    && \
    apt-get clean autoclean \
    && \
    apt-get autoremove -y \
    && \
    rm -rf /var/lib/apt/lists/* \
    && \
    mkdir -p /steamcmd \
    && \
    wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - -C /steamcmd

EXPOSE 2302/udp
EXPOSE 2303/udp
EXPOSE 2304/udp
EXPOSE 2305/udp
EXPOSE 2306/udp

WORKDIR /arma3

VOLUME /steamcmd

STOPSIGNAL SIGINT

COPY *.py /

CMD ["python3","/launch.py"]
