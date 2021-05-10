FROM php:7.4-fpm
RUN php -i
RUN apt-get update && apt-get install -y \
    cron            \
    git             \
    jekyll          \
    nginx           \
    mariadb-client  \
    unzip

RUN apt-get install -y libpng-dev
RUN docker-php-ext-install gd

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '795f976fe0ebd8b75f26a6dd68f78fd3453ce79f32ecb33e7fd087d39bfeb978342fb73ac986cd4f54edd0dc902601dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/bin
RUN php -r "unlink('composer-setup.php');"

RUN rm /etc/nginx/sites-enabled/default

RUN docker-php-ext-install mysqli pdo pdo_mysql
#CMD while true; do sleep 12 ; echo "foreground"; done
CMD cd /var/www/html/ccs-back/ && ls -l && COMPOSER_MEMORY_LIMIT=-1 /bin/composer.phar update && php artisan migrate --force && php artisan up && php artisan key:generate && php artisan proposal:process && php artisan proposal:update && chown -R www-data /var/www/html/ccs-back/ && chown -R www-data /var/www/html/ccs-front/ && service nginx reload && service nginx start && python cron.py
