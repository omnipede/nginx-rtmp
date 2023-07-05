# https://github.com/koyashiro/nginx-rtmp-module-docker/blob/main/Dockerfile
FROM arm64v8/ubuntu:latest AS builder

ENV NGINX_VERSION=1.25.1
ENV NGINX_RTMP_MODULE_VERSION=1.2.2

RUN apt-get update
RUN apt-get install --no-install-recommends --no-install-suggests -y \
        build-essential \
        ca-certificates \
        curl \
        libpcre3-dev \
        libssl-dev \
        libz-dev

WORKDIR /build
RUN curl -O "https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" \
      && tar xvzf nginx-${NGINX_VERSION}.tar.gz

RUN curl -LO "https://github.com/arut/nginx-rtmp-module/archive/refs/tags/v${NGINX_RTMP_MODULE_VERSION}.tar.gz" \
      && tar xvzf v${NGINX_RTMP_MODULE_VERSION}.tar.gz

WORKDIR /build/nginx-${NGINX_VERSION}
RUN ./configure \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --add-dynamic-module="/build/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}" \
    --with-compat \
    && make modules \
    && cp objs/ngx_rtmp_module.so /build/ngx_rtmp_module.so

FROM arm64v8/nginx:1.25.1

COPY --from=builder /build/ngx_rtmp_module.so /usr/lib/nginx/modules/ngx_rtmp_module.so

# Install ffmpeg
RUN apt update
RUN apt install -y ffmpeg