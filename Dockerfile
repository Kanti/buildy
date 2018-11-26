FROM php:alpine
MAINTAINER Matthias Vogel <git@kanti.de>

# add file for https://github.com/pluswerk/grumphp-bom-task
# @see FROM https://github.com/alpine-docker/git
RUN apk --update add file bash rsync git openssh libxml2-dev && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN docker-php-ext-install soap mysqli

# @see FROM https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN cd /bin && \
    wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet && \
    composer global require hirak/prestissimo && \
    composer clear-cache
