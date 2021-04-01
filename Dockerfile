FROM matomo:4.2.1-fpm-alpine

# Install Nginx and Supervisor: https://github.com/olkitu/docker-nginx-php-fpm/blob/main/Dockerfile

RUN apk add --no-cache nginx supervisor gettext moreutils \
    && mkdir /run/nginx/ \
    && rm -rf /var/log/nginx/access.log /var/log/nginx/error.log \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Copy configurations
COPY configs/supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY configs/nginx-default.conf /etc/nginx/conf.d/default.conf
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
