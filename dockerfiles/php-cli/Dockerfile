FROM php:8.4-cli

# 1. Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# 2. System Dependencies (Consolidated and Cleaned)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    libsqlite3-dev \
    libssl-dev \
    libicu-dev \
    libbz2-dev \
    libmemcached-dev \
    librabbitmq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    zip \
    unzip \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Install PHP core extensions
RUN docker-php-ext-install \
    intl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    mysqli \
    zip \
    soap \
    sockets \
    pcntl \
    bcmath \
    sysvsem \
    bz2 \
    opcache \
    posix \
    exif

# 4. Configure & Install GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# 5. Install PECL extensions
# Added -f to force, sometimes needed in 8.4 during early releases
RUN pecl install redis amqp memcached xdebug \
    && docker-php-ext-enable redis amqp memcached xdebug

# 6. Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 7. Final Setup (Removed the 'apk' command)
RUN chown -R 1000:1000 /var/www/html/

WORKDIR /var/www/html

CMD ["php", "-a"]