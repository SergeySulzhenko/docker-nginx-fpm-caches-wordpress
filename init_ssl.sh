#!/usr/bin/env bash

# run it in pod

letsencrypt certonly \
&& cp /etc/nginx/ssl.conf /etc/nginx/ssl.site.conf \
&& nginx -t \
&& nginx -s reload
