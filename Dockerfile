FROM php:alpine
MAINTAINER Matthias Vogel <git@kanti.de>

# add file for https://github.com/pluswerk/grumphp-bom-task
# @see FROM https://github.com/alpine-docker/git
RUN apk --update add file bash git openssh libxml2-dev && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN docker-php-ext-install soap

# @see FROM https://getcomposer.org/download/
RUN cd /bin && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    composer global require hirak/prestissimo && \
    composer clear-cache
