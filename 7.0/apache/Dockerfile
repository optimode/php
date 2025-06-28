FROM optimode/php:7.0-cli

ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars

RUN set -eux; \ 
        apt-get update; \
        apt-get install -y --no-install-recommends apache2; \
        rm -rf /var/lib/apt/lists/*; \
        sed -ri 's/^export ([^=]+)=(.*)$/: ${\1:=\2}\nexport \1/' "$APACHE_ENVVARS"; \
        \
        # setup directories and permissions
        . "$APACHE_ENVVARS"; \
        for dir in \
                "$APACHE_LOCK_DIR" \
                "$APACHE_RUN_DIR" \
                "$APACHE_LOG_DIR" \
        # https://salsa.debian.org/apache-team/apache2/-/commit/b97ca8714890ead1ba6c095699dde752e8433205
                "$APACHE_RUN_DIR/socks" \
        ; do \
                rm -rvf "$dir"; \
                mkdir -p "$dir"; \
                chown "$APACHE_RUN_USER:$APACHE_RUN_GROUP" "$dir"; \
        # allow running as an arbitrary user (https://github.com/docker-library/php/issues/743)
                chmod 1777 "$dir"; \
        done; \
        \
        # delete the "index.html" that installing Apache drops in here
        rm -rvf /var/www/html/*; \
        # delete apache config folder 
        rm -rvf /etc/apache2/*; \
        \
        # logs should go to stdout / stderr
        ln -sfT /dev/stderr "$APACHE_LOG_DIR/error.log"; \
        ln -sfT /dev/stdout "$APACHE_LOG_DIR/access.log"; \
        ln -sfT /dev/stdout "$APACHE_LOG_DIR/other_vhosts_access.log"; \
        chown -R --no-dereference "$APACHE_RUN_USER:$APACHE_RUN_GROUP" "$APACHE_LOG_DIR"

COPY ./data/apache2-foreground /usr/local/bin/
COPY --from=php:7.0-apache /usr/lib/apache2/modules/libphp7.so /usr/lib/apache2/modules/libphp.so 
COPY --from=php:7.0-apache /etc/apache2 /etc/apache2

# Apache + PHP requires preforking Apache for best results
RUN a2dismod mpm_event && a2enmod mpm_prefork

# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "org.opencontainers.image.title"="PHP 7.0 APACHE"
LABEL "org.opencontainers.image.description"="PHP 7.0 APACHE with many extensions"
LABEL "org.opencontainers.image.url"="$URL"
LABEL "org.opencontainers.image.source"="$SOURCE"
LABEL "org.opencontainers.image.version"="7.0"
LABEL "org.opencontainers.image.revision"="$REVISION"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.created"="$BUILD_DATE"
LABEL "org.opencontainers.image.authors"="$AUTHORS"
LABEL "org.opencontainers.image.vendor"="$VENDOR"
LABEL "org.opencontainers.image.base.name"="optimode/php:7.0-cli"
LABEL "org.opencontainers.image.ref.name"="7.0-apache"

WORKDIR /var/www/html
# https://httpd.apache.org/docs/2.4/stopping.html#gracefulstop
STOPSIGNAL SIGWINCH
EXPOSE 80

CMD ["apache2-foreground"]
ENTRYPOINT ["/docker-entrypoint.sh"]
