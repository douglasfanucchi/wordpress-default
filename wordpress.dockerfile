FROM alpine:3.18

RUN apk update && apk upgrade

RUN apk add php	php-phar php-tokenizer php-fpm php-soap \
	php-openssl php-gmp php-pdo_odbc php-json php-dom php-pdo php-zip \
	php-mysqli php-sqlite3 php-pdo_pgsql php-bcmath php-gd php-odbc \
	php-pdo_mysql php-pdo_sqlite php-gettext php-xml php-xmlreader \
	php-bz2 php-iconv php-pdo_dblib php-curl php-ctype php-fileinfo \
	php-opcache php-mbstring php81-pecl-imagick curl wget --no-cache

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

RUN test -d /var/www || mkdir /var/www
RUN test -d /var/www/html || mkdir /var/www/html
RUN adduser -h /var/www/html -G www-data -D www-data
RUN chown www-data:www-data /var/www/html
RUN chmod 755 /var/www/html

COPY config/php-fpm.conf /etc/php81/php-fpm.conf
COPY config/php.ini /etc/php81/php.ini

USER www-data
WORKDIR /var/www/html
RUN wget http://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm latest.tar.gz;
RUN mv wordpress/* . && rm -r wordpress

USER root

ENTRYPOINT ["php-fpm81", "-F"]