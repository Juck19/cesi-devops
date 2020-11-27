  
FROM php:7.4-apache

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

COPY ./config/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY ./config/apache.conf /etc/apache2/conf-available/verretech.conf
RUN a2enconf verretech

RUN apt-get update -qq && \
apt-get install -qy \
git gnupg unzip zip

RUN docker-php-ext-install -j$(nproc) opcache pdo_mysql

COPY ./config/php.ini /usr/local/etc/php/conf.d/app.ini
COPY ./app /app

EXPOSE 80
