# kanti/buildy
small php docker image with:
- git
- composer
- hirak/prestissimo
- pcov
- imagemagick
- gd


## Setting
to set your php setting:
````bash
echo 'memory_limit=-1' > /usr/local/etc/php/conf.d/docker-php-memlimit.ini;
````
