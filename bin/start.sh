#!/bin/sh
if [[ -z "${ENV_ROOT_PATH}" ]]; then
  ROOT_PATH="/var/www/html/site"
else
  ROOT_PATH="${ENV_ROOT_PATH}"
fi
mkdir -p "${ROOT_PATH}"

if [[ -z "${ENV_SERVER_NAME}" ]]; then
  SERVER_NAME="dev.localhost"
else
  SERVER_NAME="${ENV_SERVER_NAME}"
fi
if [ ! -f /etc/nginx/conf.d/site.conf ]; then
   	cp /etc/nginx/conf.d/site.conf.tpl /etc/nginx/conf.d/site.conf
	sed -i "s|SERVER_NAME|$SERVER_NAME|g" /etc/nginx/conf.d/site.conf
	sed -i "s|ROOT_PATH|$ROOT_PATH|g" /etc/nginx/conf.d/site.conf
fi


if [ -z "$(ls -A ${ROOT_PATH})" ]; then
   echo "<?=phpinfo()?>" > "${ROOT_PATH}/index.php"
fi

php-fpm & nginx -g "daemon off;" > /dev/null  2>&1