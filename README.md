# php7-nginx
Simple docker image contains php7 and nginx

# Usage
```
docker run -v /tmp/app:/var/www/html/site -e ENV_SERVER_NAME=test.localhost -e ENV_ROOT_PATH=/var/www/html/site -p 80:80 ivoglent/php7-nginx:latest
```