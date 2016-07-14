# small is beautiful
FROM alpine:latest

MAINTAINER Anthony Hogg anthony@hogg.fr

# The container listens on port 80, map as needed
EXPOSE 80

# We need the following:
# - git, because that gets us the git-http-backend CGI script
# - fcgiwrap, because that is how nginx does CGI
# - spawn-fcgi, to launch fcgiwrap and to create the unix socket
# - nginx, because it is our frontend
RUN apk add --update nginx && \
    apk add --update git && \
    apk add --update fcgiwrap && \
    apk add --update spawn-fcgi && \
    apk add --update apache2-utils && \
    rm -rf /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh

#RUN addgroup git && adduser -g "" -D -G git git
#RUN passwd -d 'git' git	#passwd -d 'user' passwd
RUN mkdir -p /git
#RUN chown git:git /git
#USER git
#initialize git repo
WORKDIR /git
RUN git --bare init

# This is where the repositories will be stored, and
# should be mounted from the host (or a volume container)
VOLUME ["/git"]
    

# launch fcgiwrap via spawn-fcgi; launch nginx in the foreground
# so the container doesn't die on us; supposedly we should be
# using supervisord or something like that instead, but this
# will do
CMD /run.sh
