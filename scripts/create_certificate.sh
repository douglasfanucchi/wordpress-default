#!/bin/sh
openssl req -x509 -nodes -newkey rsa:4096 -out public_key.crt -config /tmp/cert.conf;
cp ./project.key /etc/ssl/private/;
cp ./public_key.crt /etc/ssl/certs/;