# Use an official Python runtime as a parent image
FROM php:7.1-apache

# Set the working directory to /app
WORKDIR /glifico

COPY composer.json /glifico
#
# # Install dependencies
RUN apt-get update && \
apt-get install curl nano git libpq-dev libicu-dev \
libmemcached-dev zlib1g-dev libncurses5-dev libfreetype6-dev libjpeg62-turbo-dev \
libmcrypt-dev --no-install-recommends --yes && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install iconv mcrypt \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install gd \
&& docker-php-ext-install intl

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
&& docker-php-ext-install pdo pdo_pgsql pgsql

RUN php /usr/local/bin/composer install

RUN mkdir /var/www/html/project
RUN mkdir /var/www/html/project/web

RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/project\/web/g' /etc/apache2/apache2.conf

RUN echo "" >> /etc/apache2/apache2.conf
RUN echo "<Directory /var/www/html/project/>" >> /etc/apache2/apache2.conf
RUN echo "  Options FollowSymLinks" >> /etc/apache2/apache2.conf
RUN echo "  AllowOverride All" >> /etc/apache2/apache2.conf
RUN echo "  Order allow,deny" >> /etc/apache2/apache2.conf
RUN echo "  Allow from all" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf
RUN echo "" >> /etc/apache2/apache2.conf

# APC
RUN pear config-set php_ini /usr/local/etc/php/php.ini
RUN pecl config-set php_ini /usr/local/etc/php/php.ini

RUN a2enmod rewrite

RUN usermod -u 1000 www-data

# Make port 80 available to the world outside this container
EXPOSE 8080

ENV DATABASE_URL "pgsql://mekxcdysldqmrv:3e3df1ca938561aa73223bc8d8bb33478c4596d29593decf03db54ab5fe99df2@ec2-54-217-235-137.eu-west-1.compute.amazonaws.com:5432/dpcasttrrmusr?sslmode=require"
