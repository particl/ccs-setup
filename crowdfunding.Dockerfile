FROM php:7.4-fpm
RUN php -i
RUN apt-get update && apt-get install -y \
    cron            \
    git             \
    jekyll          \
    nginx           \
    mariadb-client  \
    libpng-dev      \
    unzip

RUN docker-php-ext-install gd mysqli pdo pdo_mysql

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/bin
RUN php -r "unlink('composer-setup.php');"

RUN rm /etc/nginx/sites-enabled/default

# CMD while true; do sleep 12 ; echo "foreground"; done
CMD cd /var/www/html/ccs-back/ && ls -l && /bin/composer.phar update && php artisan migrate --force && php artisan up && php artisan key:generate && php artisan proposal:process && php artisan proposal:update && chown -R www-data /var/www/html/ccs-back/ && chown -R www-data /var/www/html/ccs-front/ && service nginx reload && service nginx start && python cron.py

