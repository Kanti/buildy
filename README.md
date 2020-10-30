# kanti/buildy
small php docker image with:
- git
- composer (composer Version 2)
- composer1 (composer Version 1)
- hirak/prestissimo (for composer 1 usage)
- pcov
- imagemagick
- gd


## Setting
to set your php setting:
````bash
echo 'memory_limit=-1' > /usr/local/etc/php/conf.d/docker-php-memlimit.ini;
````
