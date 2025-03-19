FROM optimode/php:8.4-cli

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
LABEL "org.opencontainers.image.ref.name"="8.4-fpm"
LABEL "org.opencontainers.image.title"="PHP-FPM 8.4"
LABEL "org.opencontainers.image.description"="PHP-FPM 8.4"

###
### Configure
###
RUN set -eux \
    && rm -rf /usr/local/etc/php-fpm.d \
    && mkdir -p /usr/local/etc/php-fpm.d

###
### Copy files
###
COPY --from=php:8.4.5-fpm /usr/local/sbin/php-fpm /usr/local/sbin/php-fpm
COPY --from=php:8.4.5-fpm /usr/local/etc/php/conf.d/docker-fpm.ini /usr/local/etc/php/conf.d/docker-fpm.ini
COPY --from=php:8.4.5-fpm /usr/local/etc/php-fpm.d /usr/local/etc/php-fpm.d
COPY --from=php:8.4.5-fpm /usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY --from=php:8.4.5-fpm /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf.default

WORKDIR /var/www/html
STOPSIGNAL SIGQUIT
EXPOSE 9000

CMD ["/usr/local/sbin/php-fpm"]
ENTRYPOINT ["/docker-entrypoint.sh"]
