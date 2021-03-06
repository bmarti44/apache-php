#!/bin/bash
 
chown quickstart:quickstart /var/www/html -R

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

sed -i "s/export APACHE_RUN_USER=www-data/#export APACHE_RUN_USER=www-data/g" /etc/apache2/envvars
sed -i "s/export APACHE_RUN_USER=www-data/#export APACHE_RUN_USER=www-data/g" /etc/apache2/envvar

source /etc/apache2/envvars

tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
