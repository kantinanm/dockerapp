# Dockerfile
FROM php:5-apache-jessie

RUN rm /etc/apt/preferences.d/no-debian-php

RUN apt-get update &&\
    apt-get install -y \
    libmcrypt-dev \
    libpng-dev \
    zlib1g-dev \
    zip \
    unzip &&\
    a2enmod rewrite

RUN docker-php-ext-install pdo 
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd 
RUN docker-php-ext-install pcntl  
RUN docker-php-ext-install mcrypt  

COPY PHP_INI/php.ini /usr/local/etc/php/php.ini
RUN sed -i 's/;date\.timezone.*/date.timezone = ASIA\/Bangkok/g' /usr/local/etc/php/php.ini
RUN sed -i 's/;upload_max_filesize.*/upload_max_filesize = 15M/g' /usr/local/etc/php/php.ini
RUN sed -i 's/;post_max_size.*/post_max_size = 15M/g' /usr/local/etc/php/php.ini
#RUN a2enmod rewrite


WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 775 /var/www/html

COPY ./src /var/www/html/

VOLUME /var/www/html

