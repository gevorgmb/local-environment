FROM php:8.3-fpm

WORKDIR /var/www/html/app/

RUN apt-get update -y && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get install -y \
        apt-utils wget git libsasl2-dev libcurl4-openssl-dev libssl-dev libicu-dev librabbitmq-dev libxrender1 \
        libzip-dev unzip zip libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev libfontconfig1 libmemcached-dev \
        libc6 libgcc1 libsodium-dev libbz2-dev libmagickwand-dev libnss3 xvfb\
        libssh2-1-dev libssh2-1 libpq-dev nano \
        zlib1g-dev \
    	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd sockets \
        && docker-php-ext-install bz2 \
        && docker-php-ext-install opcache \
        && docker-php-ext-install bcmath \
        && docker-php-ext-install intl \
        && docker-php-ext-install zip \
        && docker-php-ext-install pdo_mysql mysqli \
        && docker-php-ext-install pgsql pdo_pgsql \
        && docker-php-ext-install soap \
        && docker-php-ext-install sysvsem \
        && apt-get clean \
