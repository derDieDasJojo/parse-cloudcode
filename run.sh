#!/bin/sh

#create password
htpasswd -cb /etc/nginx/.htpasswd $GIT_USERNAME $GIT_PASSWORD

#start server
spawn-fcgi -s /run/fcgi.sock /usr/bin/fcgiwrap && \
    nginx -g "daemon off;"
