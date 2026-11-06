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

# pcov 1.0.12 (latest release) does not build on PHP 8.6, so build the upstream fix instead
# @see https://github.com/krakjoe/pcov/tree/issue-php86a2
# TODO remove once a pcov release supports PHP 8.6
RUN if [ "${PHP%-rc}" = "8.6" ]; then \
        mkdir /tmp/pcov && \
        curl -fsSL https://codeload.github.com/krakjoe/pcov/tar.gz/f04029fa86ae58c6dfff8049de8433669dbf1394 | tar xz -C /tmp/pcov --strip-components=1 && \
        docker-php-ext-install /tmp/pcov && \
        rm -r /tmp/pcov; \
    fi

# install ext-soap ext-mysqli ext-pdo_mysql ext-pdo_sqlite ext-pcov
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN IPE_GD_WITHOUTAVIF=1 install-php-extensions pcov soap mysqli pdo_mysql pdo_sqlite gd zip calendar intl @fix_letsencrypt && \
    echo 'memory_limit=-1' > /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

# @see FROM https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q > installer && \
    cat installer | php -- --filename="composer" --install-dir="/bin" && \
    rm installer
