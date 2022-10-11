FROM nginx:alpine
ARG APP_DIR
ARG UPSTREAM_NAME
ARG FPM_PORT

COPY ./docker/nginx/conf/default.conf /etc/nginx/conf.d/
ADD ./docker/nginx/conf/nginx.conf /etc/nginx/
COPY ./docker/sites/${APP_DIR} /var/www/html/

RUN sed -ie "s/{UPSTREAM_NAME}/${UPSTREAM_NAME}/g" /etc/nginx/conf.d/default.conf
RUN sed -ie "s/{FPM_PORT}/${FPM_PORT}/g" /etc/nginx/conf.d/default.conf

EXPOSE 80