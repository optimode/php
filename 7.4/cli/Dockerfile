FROM php:7.4-cli

### Envs
ENV MY_USER="optimode" \
    MY_GROUP="optimode" \
    MY_UID="1000" \
    MY_GID="1000" \
    PHP_VERSION="7.4"

# Install dependencies
RUN set -eux \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
    procps \
    curl \
    openssh-server \
    supervisor \
    nano \
    git

# Install PHP extensions installer
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install PHP extensions
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

RUN set -eux \
    # empty apt lists
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config \
    && rm -rf /var/lib/apt/lists/* \
    # Install multiple Composer versions
    && cd /usr/local/bin \
    && curl -sSL https://getcomposer.org/installer > composer-setup.php \
    && curl -sSL https://composer.github.io/installer.sha384sum > composer-setup.sha384sum \
    && sha384sum --check composer-setup.sha384sum \
    # Install Composer 2
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --2 \
    # Install Composer 1
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer1 --1 \
    # Remove composer installer files.
    && rm /usr/local/bin/composer-setup.php /usr/local/bin/composer-setup.sha384sum \
    && mkdir -p /var/log/php \
    && mkdir -p /var/log/supervisor

# Copy files
COPY ./data/conf.d/php.ini /usr/local/etc/php/conf.d/xxx-optimode-default-php.ini
COPY ./data/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./data/docker-entrypoint.d /docker-entrypoint.d

# User/Group
RUN set -eux \
    && groupadd -g ${MY_GID} -r ${MY_GROUP} \
    && useradd -u ${MY_UID} -m -s /bin/bash -g ${MY_GROUP} ${MY_USER} \
    && mkdir -p /var/lib/php/session \
    && mkdir -p /var/lib/php/wsdlcache \
    && chown -R ${MY_UID}:${MY_GROUP} /var/lib/php/session \
    && chown -R ${MY_UID}:${MY_GROUP} /var/lib/php/wsdlcache

ARG URL
ARG SOURCE
ARG BUILD_DATE
ARG AUTHORS
ARG VENDOR
ARG REVISION

# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "org.opencontainers.image.title"="PHP 7.4 CLI"
LABEL "org.opencontainers.image.description"="PHP 7.4 CLI with many extensions"
LABEL "org.opencontainers.image.url"="$URL"
LABEL "org.opencontainers.image.source"="$SOURCE"
LABEL "org.opencontainers.image.version"="7.4"
LABEL "org.opencontainers.image.revision"="$REVISION"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.created"="$BUILD_DATE"
LABEL "org.opencontainers.image.authors"="$AUTHORS"
LABEL "org.opencontainers.image.vendor"="$VENDOR"
LABEL "org.opencontainers.image.base.name"="php:7.4-cli"
LABEL "org.opencontainers.image.ref.name"="7.4-cli"

EXPOSE 22
WORKDIR /var/www/html
CMD ["php", "-a"]
ENTRYPOINT ["/docker-entrypoint.sh"]
