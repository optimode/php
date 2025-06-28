FROM optimode/php:7.4-cli

### Configure
RUN set -eux \
    && rm -rf /usr/local/etc/php-fpm.d \
    && mkdir -p /usr/local/etc/php-fpm.d

### Copy files
COPY --from=php:7.4-fpm /usr/local/sbin/php-fpm /usr/local/sbin/php-fpm
COPY --from=php:7.4-fpm /usr/local/etc/php-fpm.d /usr/local/etc/php-fpm.d
COPY --from=php:7.4-fpm /usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY --from=php:7.4-fpm /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf.default

ARG URL
ARG SOURCE
ARG BUILD_DATE
ARG AUTHORS
ARG VENDOR
ARG REVISION

# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "org.opencontainers.image.title"="PHP 7.4 FPM"
LABEL "org.opencontainers.image.description"="PHP 7.4 FPM with many extensions"
LABEL "org.opencontainers.image.url"="$URL"
LABEL "org.opencontainers.image.source"="$SOURCE"
LABEL "org.opencontainers.image.version"="7.4"
LABEL "org.opencontainers.image.revision"="$REVISION"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.created"="$BUILD_DATE"
LABEL "org.opencontainers.image.authors"="$AUTHORS"
LABEL "org.opencontainers.image.vendor"="$VENDOR"
LABEL "org.opencontainers.image.base.name"="optimode/php:7.4-cli"
LABEL "org.opencontainers.image.ref.name"="7.4-fpm"


WORKDIR /var/www/html
STOPSIGNAL SIGQUIT
EXPOSE 9000

CMD ["/usr/local/sbin/php-fpm"]
ENTRYPOINT ["/docker-entrypoint.sh"]
