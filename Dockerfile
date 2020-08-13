FROM buildpack-deps:20.04-curl

LABEL MAINTAINER='Pawel Kostelnik <pkostelnik@gmail.com>'

### Copy entrypoint executable inplace
COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN apt-get update \
    && apt-get upgrade -y \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install -y apt-utils tzdata nano --no-install-recommends \
    && echo Europe/Berlin > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
#    && echo Europe/Berlin > /etc/timezone \
#    && apt-get install -y wget php-ldap --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && mkdir /tmp/open3A \
### open3a
    && wget -q "https://www.open3a.de/download/open3A 3.2.zip" -O open3A.zip && mv open3A.zip /tmp/open3A \
### remove standard apache configuration & modules
    && chmod +x           /usr/local/bin/docker-entrypoint \
    && unzip /tmp/open3A/open3A.zip

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80 3306

ENTRYPOINT ["docker-entrypoint"]
