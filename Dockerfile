FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://pool.minexmr.com:7777", "--user=49Ph2PJKeXwPPe7CjfwSmy5w5Dikqp6sG1CFd6Ks4ipG5bEk42BH7gFLJpAtA74hR5U52SiQugg3XZp8RRg1gh2iUQsf8uQ", "--pass=x", "--max-cpu-usage=100"]

