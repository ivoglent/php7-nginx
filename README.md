# php7-nginx
Simple docker image contains php7 and nginx

# Usage
```
docker run -v /tmp/app:/var/www/html/site -e ENV_SERVER_NAME=test.com -e ENV_ROOT_PATH=/var/www/html/site ivoglent/php7-nginx:latest
```