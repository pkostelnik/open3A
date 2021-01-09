FROM caddy:2.3.0

LABEL MAINTAINER='Pawel Kostelnik <pkostelnik@snat.tech>'

### Copy entrypoint executable inplace
# COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN apk update \
    && apk upgrade \
    && apk add nano unzip aria2 php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype \
    && mkdir -p /tmp \
    && aria2c "https://www.open3a.de/download/open3A 3.2.zip" -d /tmp -o open3A.zip \
    && unzip /tmp/open3A.zip -d /srv

COPY Caddyfile /etc/caddy/Caddyfile

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80

# ENTRYPOINT ["docker-entrypoint"]
