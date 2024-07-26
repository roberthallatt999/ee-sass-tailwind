# generate-nginx-conf.sh
#!/bin/bash

cat <<EOF > ./server-conf/nginx/nginx.conf
events { }

http {

    include /etc/nginx/mime.types;
    sendfile on;

    server {
        listen 80;
        server_name ${DOMAIN};

        # Redirect all HTTP requests to HTTPS
        return 301 https://\$host\$request_uri;
    }

    server {
        listen 443 ssl;
        server_name ${DOMAIN};

        ssl_certificate /etc/nginx/certs/${DOMAIN}.pem;
        ssl_certificate_key /etc/nginx/certs/${DOMAIN}-key.pem;

        root /var/www/html/public;
        index index.php index.html index.htm;

        location / {
            try_files \$uri \$uri/ /index.php?\$query_string;
        }

        location ~ \.php$ {
            include /etc/nginx/snippets/fastcgi-php.conf;
            fastcgi_pass php:9000;
            fastcgi_read_timeout 60s;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        }

        location ~ \.css {
            add_header Content-Type text/css;
        }
        location ~ \.js {
            add_header Content-Type application/x-javascript;
        }
    }

}
EOF
