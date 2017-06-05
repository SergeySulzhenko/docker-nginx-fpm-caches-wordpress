#!/usr/bin/env bash

. `dirname $0`/../wp-dock/.env
umask 007

docker exec wp_web_1 tar -cvzf ${BACKUP_DIR}/wwwdata_`date +%w`.tgz /usr/share/nginx/www

docker exec wp_db_1 mysqldump -u $WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME \
    | gzip > $BACKUP_DIR/mysql/${WP_DB_NAME}_`date +%w`.sql.gz

chown -R admin:admin ${BACKUP_DIR}
chmod -R u=rwX,g=rX,o-rwX ${BACKUP_DIR}
