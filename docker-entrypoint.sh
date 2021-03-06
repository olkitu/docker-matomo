#!/bin/sh
# From: https://github.com/matomo-org/docker/blob/master/fpm-alpine/docker-entrypoint.sh
set -e

ENV_VARIABLES=$(awk 'BEGIN{for(v in ENVIRON) print "$"v}')

for FILE in /var/www/html/config/config.ini.php
do
    envsubst "$ENV_VARIABLES" <$FILE | sponge $FILE
done

if [ ! -e matomo.php ]; then
	tar cf - --one-file-system -C /usr/src/matomo . | tar xf -
	chown -R www-data:www-data .
fi

if [ ! -e '/var/www/html/misc/DBIP-City.mmdb' ]; then
    mv /tmp/DBIP-City.mmdb.gz /var/www/html/misc/DBIP-City.mmdb.gz
    gzip -d /var/www/html/misc/DBIP-City.mmdb.gz
    chown www-data:www-data /var/www/html/misc/DBIP-City.mmdb
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf "$@"
fi

exec "$@"