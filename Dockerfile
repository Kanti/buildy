ARG PHP=8.4
FROM php:${PHP}-alpine
ARG PHP=8.4

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    PHP_MAIN_VERSION=${PHP}

# add file for https://github.com/pluswerk/grumphp-bom-task
# @see FROM https://github.com/alpine-docker/git
RUN apk --update add file bash jq rsync git openssh libxml2-dev patch imagemagick libpng-dev unzip docker-cli docker-cli-compose && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

# install ext-soap ext-mysqli ext-pcov
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN IPE_GD_WITHOUTAVIF=1 install-php-extensions pcov soap mysqli gd zip calendar intl @fix_letsencrypt && \
    echo 'memory_limit=-1' > /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

# @see FROM https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q > installer && \
    cat installer | php -- --filename="composer" --install-dir="/bin" && \
    cat installer | php -- --filename="composer1" --1 --install-dir="/bin" && \
    rm installer
