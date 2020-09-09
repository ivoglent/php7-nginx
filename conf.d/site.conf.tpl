
server {
    listen 80;
    listen 443 ;
    listen [::]:443;
    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root ROOT_PATH;
    server_name SERVER_NAME;
    location ~ \.php$ {
        if ($request_method = OPTIONS ) {
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Methods' 'POST, OPTIONS';
            add_header Content-Length 0;
            add_header Content-Type text/plain;
            return 200;
        }
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param PROXY_FORWARDED $proxy_add_x_forwarded_for;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }
 
    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }
 
    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ { # static assets. I'm using CloudFront.
        gzip_static on;
        gzip_http_version 1.0;
        expires max;
        add_header Cache-Control public;
        add_header Last-Modified "";
        log_not_found off;
    }
 
    location ~* \.(eot|svg|ttf|woff|swf|xap)$ { # this is for fonts and flash upload
        expires max;
        add_header Cache-Control public;
        add_header Last-Modified "";
        add_header Access-Control-Allow-Origin *; # need to allow this for firefox
        log_not_found off;
    }
    try_files $uri $uri/ /index.php?$query_string;
}
