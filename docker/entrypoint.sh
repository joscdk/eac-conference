#!/bin/bash

if [[ ! -z "${PHP_MEMORY_LIMIT}" ]]; then
  sed -i "s,memory_limit = 128M,memory_limit = ${PHP_MEMORY_LIMIT},g" /etc/php/${PHP_VERSION}/fpm/php.ini
  sed -i "s,opcache.memory_consumption = 128M,opcache.memory_consumption = ${PHP_MEMORY_LIMIT},g" /etc/php/${PHP_VERSION}/fpm/php.ini
fi

if [[ ! -z "${PHP_MAX_CHILDREN}" ]]; then
  sed -i "s,pm.max_children = 5,pm.max_children = ${PHP_MAX_CHILDREN},g" /etc/php/${PHP_VERSION}/fpm/pool.d/laravel.conf
fi

if [[ ! -z "${PHP_START_SERVERS}" ]]; then
  sed -i "s,pm.start_servers = 2,pm.start_servers = ${PHP_START_SERVERS},g" /etc/php/${PHP_VERSION}/fpm/pool.d/laravel.conf
fi

if [[ ! -z "${PHP_MIN_SPARE_SERVERS}" ]]; then
  sed -i "s,pm.min_spare_servers = 1,pm.min_spare_servers = ${PHP_MIN_SPARE_SERVERS},g" /etc/php/${PHP_VERSION}/fpm/pool.d/laravel.conf
fi

if [[ ! -z "${PHP_MAX_SPARE_SERVERS}" ]]; then
  sed -i "s,pm.max_spare_servers = 3,pm.max_spare_servers = ${PHP_MAX_SPARE_SERVERS},g" /etc/php/${PHP_VERSION}/fpm/pool.d/laravel.conf
fi

if [[ ! -z "${PHP_MAX_REQUESTS}" ]]; then
  sed -i "s,pm.max_requests = 500,pm.max_requests = ${PHP_MAX_REQUESTS},g" /etc/php/${PHP_VERSION}/fpm/pool.d/laravel.conf
fi

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
