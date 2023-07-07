FROM alpine:3.18

RUN apk update && apk upgrade
RUN apk add nginx openssl --no-cache

COPY config/nginx.conf /etc/nginx
COPY config/cert.conf /tmp/cert.conf
COPY scripts/create_certificate.sh /tmp

RUN /tmp/create_certificate.sh && rm /tmp/create_certificate.sh

ENTRYPOINT ["nginx", "-g", "daemon off;"]