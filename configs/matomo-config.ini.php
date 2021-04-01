; <?php exit; ?> DO NOT REMOVE THIS LINE
; file automatically generated or modified by Matomo; you can manually override the default values in global.ini.php by redefining them in this file.
[database]
host = "${MATOMO_DATABASE_HOST}"
username = "${MATOMO_DATABASE_USERNAME}"
password = "${MATOMO_DATABASE_PASSWORD}"
dbname = "${MATOMO_DATABASE_DBNAME}"
tables_prefix = "${MATOMO_DATABASE_TABLES_PREFIX}"
charset = "${MATOMO_DATABASE_CHARSET}"
use_ssl = ${MATOMO_USE_SSL}

[log]
log_writers[] = "screen"
log_level = "INFO"
logger_file_path = "tmp//piwik.log"

[General]
force_ssl = ${MATOMO_FORCE_SSL}
assume_secure_protocol = ${MATOMO_ASUME_SECURE_PROTOCOL}
salt = "${MATOMO_SALT}"
proxy_client_headers[] = "${MATOMO_PROXY_CLIENT_HEADERS}"

[mail]
transport = "${MATOMO_MAIL_TRANSPORT}"
port = "${MATOMO_MAIL_PORT}"
host = "${MATOMO_MAIL_HOST}"
type = "${MATOMO_MAIL_TYPE}"
username = "${MATOMO_MAIL_USERNAME}"
password = "${MATOMO_MAIL_PASSWORD}"
encryption = "${MATOMO_MAIL_ENCRYPTION}"