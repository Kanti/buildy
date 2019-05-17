ARG FROM=php:alpine
FROM $FROM
MAINTAINER Matthias Vogel <git@kanti.de>

# add file for https://github.com/pluswerk/grumphp-bom-task
# @see FROM https://github.com/alpine-docker/git
RUN apk --update add file bash rsync git openssh libxml2-dev patch && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN docker-php-ext-install soap mysqli

# @see FROM https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q | php -- --filename="composer" --install-dir="/bin" && \
    composer global require hirak/prestissimo && \
    composer clear-cache
