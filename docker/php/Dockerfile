FROM php:8.0-fpm-alpine
ARG APP_DIR

COPY ./docker/sites/${APP_DIR} /var/www/html/

WORKDIR /var/www/html/
RUN chown www-data -R storage/