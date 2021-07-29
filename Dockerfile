FROM matomo:4.4.0-fpm-alpine

# Default environment variables
ENV MATOMO_DATABASE_HOST=localhost \
    MATOMO_DATABASE_ADAPTER=mysql \
    MATOMO_DATABASE_TABLES_PREFIX=matomo_ \
    MATOMO_DATABASE_USERNAME=matomo \
    MATOMO_DATABASE_PASSWORD=matomo \
    MATOMO_DATABASE_DBNAME=matomo \
    MATOMO_DATABASE_CHARSET=utf8mb4 \
    MATOMO_ASUME_SECURE_PROTOCOL=0 \
    MATOMO_PROXY_CLIENT_HEADERS='' \
    MATOMO_SALT=changeme \
    MATOMO_MAIL_TRANSPORT=smtp \
    MATOMO_MAIL_PORT=25 \
    MATOMO_MAIL_HOST=localhost \
    MATOMO_MAIL_TYPE=Login \
    MATOMO_MAIL_USERNAME=null \
    MATOMO_MAIL_PASSWORD=null \
    MATOMO_MAIL_ENCRYPTION=null

# Install Nginx and Supervisor: https://github.com/olkitu/docker-nginx-php-fpm/blob/main/Dockerfile
RUN apk add --no-cache nginx supervisor gettext moreutils \
    && mkdir -p /run/nginx/ \
    && rm -rf /var/log/nginx/access.log /var/log/nginx/error.log \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && wget -q -O /tmp/DBIP-City.mmdb.gz https://download.db-ip.com/free/dbip-city-lite-`date +%Y-%m`.mmdb.gz

# Copy configurations
COPY configs/supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY configs/nginx-default.conf /etc/nginx/http.d/default.conf
COPY configs/matomo-config.ini.php /var/www/html/config/config.ini.php


RUN { \
		echo 'expose_php = Off'; \
	} > /usr/local/etc/php/conf.d/php-production-override.ini

# Copy entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 700 /docker-entrypoint.sh \
    && sed -i 's/\r//' /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
