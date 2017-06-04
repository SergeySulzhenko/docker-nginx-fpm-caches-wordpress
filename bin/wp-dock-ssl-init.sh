#!/usr/bin/env bash

cd /home/admin/wp-dock
docker-compose exec web /init_ssl.sh

exit 0