FROM php:8.4-cli

###
### Labels
###
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
#LABEL "org.opencontainers.image.created"=""
#LABEL "org.opencontainers.image.version"=""
#LABEL "org.opencontainers.image.revision"=""
LABEL "maintainer"="Laszlo Malina <laszlo@malina.hu>"
LABEL "org.opencontainers.image.authors"="Laszlo Malina <laszlo@malina.hu>"
LABEL "org.opencontainers.image.url"="https://github.com/optimode/docker-php"
LABEL "org.opencontainers.image.documentation"="https://github.com/optimode/docker-php"
LABEL "org.opencontainers.image.source"="https://github.com/optimode/docker-php"
LABEL "org.opencontainers.image.vendor"="optimode"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.ref.name"="8.4-cli"
LABEL "org.opencontainers.image.title"="PHP-CLI 8.4"
LABEL "org.opencontainers.image.description"="PHP-CLI 8.4"

###
### Envs
###
ENV MY_USER="optimode" \
    MY_GROUP="optimode" \
    MY_UID="1000" \
    MY_GID="1000" \
    PHP_VERSION="8.4"


###
### User/Group
###
RUN set -eux \
    && groupadd -g ${MY_GID} -r ${MY_GROUP} \
    && useradd -u ${MY_UID} -m -s /bin/bash -g ${MY_GROUP} ${MY_USER}

RUN set -eux \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
    procps \
    curl \
    git

###
### Configure
###
RUN set -eux \
    && mkdir -p /var/lib/php/session \
    && mkdir -p /var/lib/php/wsdlcache \
    && chown -R optimode:optimode /var/lib/php/session \
    && chown -R optimode:optimode /var/lib/php/wsdlcache

###
### Copy files
###
COPY ./data/conf.d/php.ini /usr/local/etc/php/conf.d/xxx-optimode-default-php.ini
COPY ./data/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./data/docker-entrypoint.d /docker-entrypoint.d

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions \
    amqp \
    apcu \
    bcmath \
    bz2 \
    calendar \
    csv \
    dba \
    enchant \
    exif \
    ftp \
    gd \
    gettext \
    gmp \
    gnupg \
    grpc \
    http \
    igbinary \
    imagick \
    imap \
    intl \
    lz4 \
    lzf \
    memcache \
    memcached \
    mongodb \
    msgpack \
    mysqli \
    oauth \
    opcache \
    pcntl \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    pkcs11 \
    protobuf \
    pspell \
    psr \
    redis \
    shmop \
    snmp \
    soap \
    sockets \
    sodium \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    timezonedb \
    uploadprogress \
    uuid \
    xdebug \
    xhprof \
    xlswriter \
    xmlrpc \
    xsl \
    yaml \
    zip \
    zstd

# Download installer and check for its integrity.
RUN cd /usr/local/bin \
    && curl -sSL https://getcomposer.org/installer > composer-setup.php \
    && curl -sSL https://composer.github.io/installer.sha384sum > composer-setup.sha384sum \
    && sha384sum --check composer-setup.sha384sum \
    # Install Composer 2.
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --2 \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer1 --1 \
    # Remove installer files.
    && rm /usr/local/bin/composer-setup.php /usr/local/bin/composer-setup.sha384sum

RUN rm -rf /var/lib/apt/lists/*


WORKDIR /var/www/html

CMD ["php", "-a"]
ENTRYPOINT ["/docker-entrypoint.sh"]
