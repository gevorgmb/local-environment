FROM php:8.4-fpm-alpine

# Install runtime packages
RUN apk add --no-cache \
    bzip2 \
    bash \
    libpng \
    libjpeg-turbo \
    freetype \
    icu \
    libzip \
    rabbitmq-c \
    libmemcached \
    imagemagick \
    cyrus-sasl

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    build-base \
    curl-dev \
    freetype-dev \
    gcc \
    g++ \
    git \
    icu-dev \
    imagemagick-dev \
    libevent-dev \
    libjpeg-turbo-dev \
    libmemcached-dev \
    libpng-dev \
    libtool \
    libxml2-dev \
    libzip-dev \
    linux-headers \
    make \
    oniguruma-dev \
    pcre-dev \
    pkgconfig \
    rabbitmq-c-dev \
    unzip \
    zip \
    zlib-dev \
    bzip2-dev \
    cyrus-sasl-dev \
    $PHPIZE_DEPS

# Install PHP extensions
RUN docker-php-ext-install \
    intl \
    mbstring \
    pdo \
    pdo_mysql \
    mysqli \
    zip \
    xml \
    sockets \
    soap \
    pcntl \
    bcmath \
    sysvsem \
    bz2 \
    opcache

# Configure GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Symlink fix for ImageMagick config if needed
RUN if [ ! -f /usr/bin/MagickWand-config ]; then ln -s /usr/bin/MagickWand-config6 /usr/bin/MagickWand-config; fi

# Verify MagickWand config (optional)
RUN export PATH=$PATH:/usr/bin && which MagickWand-config && MagickWand-config --version

# Install PECL extensions
RUN pecl install redis amqp memcached memcache xdebug \
    && docker-php-ext-enable redis amqp memcached memcache xdebug

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clean up only build deps
RUN apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/php/tests

# Fix wrong `extension=xxx.so` errors
RUN find /usr/local/etc/php/conf.d/ -name '*.ini' -exec sed -i 's/extension=\(.*\)\.so/extension=\1/' {} \;

# Permissions
RUN chown -R 1000:1000 /var/www/html/

WORKDIR /var/www/html

# Expose the port PHP server will run on
EXPOSE 9000

CMD ["php", "-S", "0.0.0.0:9000", "-t", "/var/www/html/public"]
