FROM caddy:2.3.0
# ARG TARGETPLATFORM

LABEL MAINTAINER='Pawel Kostelnik <pkostelnik@snat.tech>'

### Copy entrypoint executable inplace
# COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN apk update \
    && apk upgrade \
    && apk add nano unzip aria2 \
    && mkdir -p /tmp \
    && aria2c "https://www.open3a.de/download/open3A 3.2.zip" -d /tmp -o open3A.zip \
    && unzip /tmp/open3A.zip -d /srv

COPY Caddyfile /etc/caddy/Caddyfile

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80
EXPOSE 443
EXPOSE 2019

# ENTRYPOINT ["docker-entrypoint"]
