FROM alpine:latest
ARG S6_OVERLAY_VERSION=3.0.0.2-2

ARG TARGETARCH
ARG TARGETVARIANT

ENV USERNAME samba
ENV PASSWORD super-secure-password
ENV PUID 1000
ENV PGID 1000

COPY src/get-s6.sh /tmp
RUN apk add --no-cache openssl curl samba-server samba-common-tools && \
  /tmp/get-s6.sh $S6_OVERLAY_VERSION $TARGETARCH $TARGETVARIANT

COPY etc/ /etc/

EXPOSE 139/tcp 445/tcp 137/udp 138/udp

ENTRYPOINT ["/init"]
