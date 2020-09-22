ARG FROM=php:alpine
FROM $FROM
MAINTAINER Matthias Vogel <git@kanti.de>

# add file for https://github.com/pluswerk/grumphp-bom-task
# @see FROM https://github.com/alpine-docker/git
RUN apk --update add file bash rsync git openssh libxml2-dev patch imagemagick && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

# install ext-soap ext-mysqli ext-pcov
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions pcov soap mysqli

# @see FROM https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q | php -- --filename="composer" --install-dir="/bin" && \
    composer global require hirak/prestissimo && \
    composer clear-cache
