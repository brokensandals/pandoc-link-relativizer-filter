FROM alpine:3.18.3

RUN cd /opt \
    && wget -O pandoc.tar.gz https://github.com/jgm/pandoc/releases/download/3.1.6/pandoc-3.1.6-linux-arm64.tar.gz \
    && tar -xzf pandoc.tar.gz \
    && mv pandoc*/ pandoc/ \
    && rm pandoc.tar.gz

ENV PATH "$PATH:/opt/pandoc/bin"
